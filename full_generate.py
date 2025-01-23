import json
import argparse

import torch
from torch.nn import functional as F

from tqdm import tqdm
from dataclasses import dataclass
from typing import Any, Dict, List, Optional, Tuple, TypedDict, Union

from transformers.cache_utils import DynamicCache
from transformers.modeling_outputs import CausalLMOutputWithPast
from transformers.models.llama.modeling_llama import LlamaRotaryEmbedding, LlamaConfig, LlamaForCausalLM

from transformers import (
    AutoTokenizer, PreTrainedTokenizer, AutoModelForCausalLM, PreTrainedModel, GenerationConfig, set_seed, AutoConfig
)


SFTDataInstanceInputs = TypedDict("SFTDataInstanceInputs", {
    "input_ids": List[int],
    "labels": List[int]
})

SFTDataInstance = TypedDict("SFTDataInstance", {
    "prompt": str,
    "answers": List[str],
    "generated": str,
    "inputs": SFTDataInstanceInputs
})


@torch.no_grad()
def generate(
        prompt: str, generation_config: GenerationConfig, model: LlamaForCausalLM,
        tokenizer: PreTrainedTokenizer
) -> str:
    input_ids = torch.tensor(
            data=[tokenizer.encode(prompt, add_special_tokens=False)],
            dtype=torch.int64,
            device=model.device
    )
    input_length = input_ids.size(-1)
    attention_mask = torch.ones_like(input_ids, dtype=torch.int64, device=model.device)
    outputs = model.generate(
        input_ids=input_ids, generation_config=generation_config, past_key_values=DynamicCache(),
        use_cache=True, eos_token_id=None, # [tokenizer.eos_token_id], 
        tokenizer=tokenizer, 
        attention_mask=attention_mask, pad_token_id=tokenizer.eos_token_id
    )
    return tokenizer.decode(token_ids=outputs[0][input_length:].tolist())


@dataclass
class Args:
    model_name: str
    input_file: str
    output_file: str
    interactive: bool = False
    num: int = 500


def parse_args() -> Args:
    parser = argparse.ArgumentParser()
    parser.add_argument("--model_name", type=str)
    parser.add_argument("--input_file", type=str)
    parser.add_argument("--output_file", type=str)
    parser.add_argument("--interactive", type=bool, default=False)
    parser.add_argument("--num", type=int, default=50)
    args = parser.parse_args()
    return Args(model_name=args.model_name, input_file=args.input_file, 
                output_file=args.output_file, interactive=args.interactive,
                num=args.num)


def write_jsonline(fp: str, obj: List[Any]):
    with open(fp, "w", encoding="utf-8") as f:
        for i in obj:
            f.write(json.dumps(i, ensure_ascii=False) + "\n")


def main():
    args = parse_args()
    set_seed(seed=42)

    with open(args.input_file, "r", encoding='utf-8') as f:
        dataset: List[SFTDataInstance] = [json.loads(i) for i in f ]

    model: LlamaForCausalLM = AutoModelForCausalLM.from_pretrained(
        pretrained_model_name_or_path=args.model_name,
        torch_dtype=torch.bfloat16,
        device_map="cuda:0",
        attn_implementation="flash_attention_2"
    )

    config: LlamaConfig = AutoConfig.from_pretrained(pretrained_model_name_or_path=args.model_name)
    model.eval()

    tokenizer: PreTrainedTokenizer = AutoTokenizer.from_pretrained(
        pretrained_model_name_or_path=args.model_name,
        use_fast=False
    )

    generation_config = GenerationConfig(
        do_sample=False,
        temperature=1.0,
        repetition_penalty=1.0,
        num_beams=1,
        eos_token_id=None,
        # eos_token_id=tokenizer.eos_token_id,
        max_new_tokens=200,
        # stop_strings=['<|im_end|>', "<|eot_id|>", "<|end_of_text|>", "<|endoftext|>"]
    )

    max_num = args.num
    count = 0
    res = []
    for i in dataset:
        if count % 10 == 0:
            print(f"Processed {count}/{max_num} prompts")
        if count >= max_num:
            break
        generated = generate(
            prompt=i["prompt"], generation_config=generation_config, model=model, tokenizer=tokenizer
        )
        i["generated"] = generated
        print(i["generated"])
        if args.interactive:
            print("Prompt:")
            print(i["prompt"])
            print("Generated: ")
            print(i["generated"])
            input()
        res.append(i)
        count += 1
    
    write_jsonline(args.output_file, res)



if __name__ == '__main__':
    main()
    from transformers.training_args import TrainingArguments
