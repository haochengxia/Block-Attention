from openai import OpenAI
import json
import fire
from dataclasses import dataclass
import random
from typing import Any, Dict, List, Union, Optional
from tqdm import trange

@dataclass
class Args:
    input: str
    output: str


client = OpenAI(
    # defaults to os.environ.get("OPENAI_API_KEY")
    api_key="sk-",
    base_url="https://api.chatanywhere.tech/v1"
    # base_url="https://api.chatanywhere.org/v1"
)


def replace_special_tokens_to_openai_format(text):
    replacements = {
        "<|begin_of_text|>": "",                     
        "<|end_of_text|>": "",                      
        "<|start_header_id|>": "[HEADER]",           
        "<|end_header_id|>": "[/HEADER]",           
        "<|eot_id|>": "[END_OF_TEXT]",        
    }
    
    for token, replacement in replacements.items():
        text = text.replace(token, replacement)
    
    return text.strip()


def generate_output(data_instance):
    prompt = replace_special_tokens_to_openai_format(data_instance["prompt"])

    completion = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": prompt}
        ],
        temperature=0.7,
        max_tokens=200
    )

    data_instance["generated"] = completion.choices[0].message.content
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

# python3 data_process/generate.py --input cache/2wiki_train/dataset_p20k --output cache/2wiki_train/dataset_p20k_generated
