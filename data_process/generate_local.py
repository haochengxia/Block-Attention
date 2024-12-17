import json
import fire
from dataclasses import dataclass
import random
from typing import Any, List, Dict
from tqdm import trange
from transformers import AutoModelForCausalLM, AutoTokenizer
import torch


@dataclass
class Args:
    input: str
    output: str

device = 'cuda' if torch.cuda.is_available() else 'cpu'

MODEL_PATH = "meta-llama/Llama-3.1-8B-Instruct"
tokenizer = AutoTokenizer.from_pretrained(MODEL_PATH)
model = AutoModelForCausalLM.from_pretrained(MODEL_PATH).to(device).eval()

def replace_special_tokens_to_openai_format(text):
    replacements = {
        "<|begin_of_text|>": "",                     
        "<|end_of_text|>": "", # "</s>",                   
        "<|start_header_id|>": "", # "[HEADER]",           
        "<|end_header_id|>": "", # "[/HEADER]",           
        "<|eot_id|>": "", # "</s>",        
    }
    
    for token, replacement in replacements.items():
        text = text.replace(token, replacement)
    
    return text.strip()


def generate_output(data_instance):
    prompt = replace_special_tokens_to_openai_format(data_instance["prompt"])

    # Tokenize prompt and generate response using Llama model
    inputs = tokenizer(prompt, return_tensors="pt", truncation=True).to(device)
    outputs = model.generate(
        **inputs,
        max_new_tokens=200,
        temperature=0.7,
        # do_sample=True,
    )
    generated_text = tokenizer.decode(outputs[0], skip_special_tokens=True)
    if generated_text.startswith(prompt):
        generated_text = generated_text[len(prompt):].strip()
    data_instance["generated"] = generated_text
    print(f"[INFO] {data_instance['generated']}")
    return data_instance


def load_jsonline(fp: str) -> List[Any]:
    with open(fp, "r", encoding="utf-8") as f:
        return [json.loads(i) for i in f]


def write_jsonline(fp: str, obj: List[Any]):
    with open(fp, "w", encoding="utf-8") as f:
        for i in obj:
            f.write(json.dumps(i, ensure_ascii=False) + "\n")


def generate_output_batch(ds):
    res = []
    for i in trange(len(ds)):
        res.append(generate_output(ds[i]))
    return res


if __name__ == '__main__':
    args: Args = fire.Fire(component=Args)
    random.seed(42)
    ds = load_jsonline(fp=args.input)
    ds = generate_output_batch(ds)
    write_jsonline(fp=args.output, obj=ds)

