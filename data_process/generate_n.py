# !pip install openai==0.28.1
import openai

# Parameters
openai.api_type = "azure"
openai.api_base = "https://eastus2test12.openai.azure.com/"
openai.api_version = "2023-05-15"
openai.api_key = "" 
model = "gpt-3.5-turbo" 

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
    completion = openai.ChatCompletion.create(
        engine = 'gpt-35-turbo',
        temperature = 0.7,
        messages = [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": prompt}
        ],
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
