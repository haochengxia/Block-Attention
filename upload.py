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
    AutoTokenizer, PreTrainedTokenizer, AutoModelForCausalLM, PreTrainedModel, GenerationConfig, set_seed, AutoConfig, 
    LogitsProcessor
)


@dataclass
class Args:
    model_name: str


def parse_args() -> Args:
    parser = argparse.ArgumentParser()
    parser.add_argument("--model_name", type=str)
    args = parser.parse_args()
    return Args(model_name=args.model_name)


def main():
    args = parse_args()

    model: LlamaForCausalLM = AutoModelForCausalLM.from_pretrained(
        pretrained_model_name_or_path=args.model_name,
        torch_dtype=torch.bfloat16,
        device_map="cuda:0",
        attn_implementation="flash_attention_2"
    )
    config: LlamaConfig = AutoConfig.from_pretrained(pretrained_model_name_or_path=args.model_name)

    model.push_to_hub("hxia7/Llama-3-8B-block")


if __name__ == '__main__':
    main()
    from transformers.training_args import TrainingArguments
