import os
import json
import argparse
import regex
import string
import statistics
from tqdm import tqdm
from dataclasses import dataclass
from typing import Any, Dict, List, TypedDict

# ------------------ Types ------------------
Document = TypedDict("Document", {"title": str, "text": str, "score": float})

SFTDataInstanceInputs = TypedDict("SFTDataInstanceInputs", {
    "input_ids": List[int],
    "labels": List[int]
})

SFTDataInstance = TypedDict("SFTDataInstance", {
    "prompt": str,
    "question": str,
    "answers": List[str],
    "generated": str,
    "inputs": SFTDataInstanceInputs,
    "documents": List[Document]
})


# ------------------ Utils ------------------
def load_jsonline(fp: str) -> List[Any]:
    with open(fp, "r", encoding="utf-8") as f:
        return [json.loads(i) for i in f]

@dataclass
class EvalArgs:
    input: str

def normalize_answer(s: str) -> str:
    """Normalization from the SQuAD evaluation script."""
    def remove_articles(text):
        return regex.sub(r"\b(a|an|the)\b", " ", text)

    def white_space_fix(text):
        return " ".join(text.split())

    def remove_punc(text):
        exclude = set(string.punctuation)
        return "".join(ch for ch in text if ch not in exclude)

    def lower(text):
        return text.lower()

    return white_space_fix(remove_articles(remove_punc(lower(s))))

def best_subspan_em(prediction: str, ground_truths: List[str]) -> float:
    if isinstance(ground_truths[0], list):
        ground_truths = ground_truths[0]

    normalized_prediction = normalize_answer(prediction)
    for ground_truth in ground_truths:
        normalized_ground_truth = normalize_answer(ground_truth)
        if normalized_ground_truth.lower() in normalized_prediction.lower():
            return 1.0
    return 0.0

def precision_recall_f1(prediction: str, ground_truths: List[str]) -> Dict[str, float]:
    """
    Calculate precision, recall, and F1 score for a single example.
    """
    if isinstance(ground_truths[0], list):
        ground_truths = ground_truths[0]

    normalized_prediction = normalize_answer(prediction).split()
    normalized_ground_truths = [normalize_answer(gt).split() for gt in ground_truths]

    ground_truth_set = set(word for gt in normalized_ground_truths for word in gt)
    prediction_set = set(normalized_prediction)

    true_positives = len(prediction_set & ground_truth_set)
    precision = true_positives / len(prediction_set) if prediction_set else 0.0
    recall = true_positives / len(ground_truth_set) if ground_truth_set else 0.0
    f1 = (2 * precision * recall) / (precision + recall) if (precision + recall) > 0 else 0.0

    return {"precision": precision, "recall": recall, "f1": f1}

METRICS = [
    (best_subspan_em, "best_subspan_em"),
    (precision_recall_f1, "precision_recall_f1"),
]

def get_metrics_for_example(example: SFTDataInstance):
    gold_answers = example["answers"]
    model_answer = example["generated"].split("<|im_end|>")[0].split("<|eot_id|>")[0]

    example_metrics = {}
    for (metric, metric_name) in METRICS:
        result = metric(prediction=model_answer, ground_truths=gold_answers)
        if isinstance(result, dict):  # For metrics with multiple outputs like precision/recall/F1
            for sub_metric_name, sub_metric_value in result.items():
                example_metrics[f"{metric_name}_{sub_metric_name}"] = sub_metric_value
        else:
            example_metrics[metric_name] = result
    return example_metrics, example

@dataclass
class Args:
    input: str

def parse_args() -> Args:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", type=str)
    parser.add_argument("--input_file", type=str)
    parser.add_argument("--output_file", type=str)
    parser.add_argument("--interactive", type=bool, default=False)
    parser.add_argument("--num", type=int, default=500)
    args = parser.parse_args()
    return Args(input=args.input)

def main():
    args = parse_args()
    if os.path.isfile(args.input):
        all_examples: List[SFTDataInstance] = load_jsonline(fp=args.input)
    else:
        all_examples: List[SFTDataInstance] = []
        for f_name in os.listdir(args.input):
            fp = os.path.join(args.input, f_name)
            all_examples.extend(load_jsonline(fp=fp))

    all_example_metrics = []
    for example in tqdm(all_examples, total=len(all_examples), desc="Eval: "):
        if example["generated"] is None:
            print("broken example", example)
            continue
        all_example_metrics.append(get_metrics_for_example(example=example))

    print("All Examples: ", len(all_examples))

    metric_summaries = {}
    for metric_name in all_example_metrics[0][0].keys():
        values = [em[metric_name] for em, _ in all_example_metrics]
        metric_summaries[metric_name] = statistics.mean(values)

    for metric_name, average in metric_summaries.items():
        print(f"{metric_name}: {average}")

if __name__ == '__main__':
    # args: EvalArgs = fire.Fire(component=EvalArgs)
    main()

