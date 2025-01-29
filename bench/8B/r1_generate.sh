# for block manner
python3 block_generate.py --model_name deepseek-ai/DeepSeek-R1-Distill-Llama-8B --input_file cache/2wiki_eval/dataset --output_file cache/benchmark/block_2wiki_r1
python3 block_generate.py --model_name deepseek-ai/DeepSeek-R1-Distill-Llama-8B --input_file cache/hqa_eval/dataset --output_file cache/benchmark/block_hqa_r1
python3 block_generate.py --model_name deepseek-ai/DeepSeek-R1-Distill-Llama-8B --input_file cache/tqa_eval/dataset --output_file cache/benchmark/block_tqa_r1
python3 block_generate.py --model_name deepseek-ai/DeepSeek-R1-Distill-Llama-8B --input_file cache/nq_eval/dataset --output_file cache/benchmark/block_nq_r1


# for full manner
python3 full_generate.py --model_name deepseek-ai/DeepSeek-R1-Distill-Llama-8B --input_file cache/2wiki_eval/dataset --output_file cache/benchmark/full_2wiki_r1
python3 full_generate.py --model_name deepseek-ai/DeepSeek-R1-Distill-Llama-8B --input_file cache/hqa_eval/dataset --output_file cache/benchmark/full_hqa_r1
python3 full_generate.py --model_name deepseek-ai/DeepSeek-R1-Distill-Llama-8B --input_file cache/tqa_eval/dataset --output_file cache/benchmark/full_tqa_r1
python3 full_generate.py --model_name deepseek-ai/DeepSeek-R1-Distill-Llama-8B --input_file cache/nq_eval/dataset --output_file cache/benchmark/full_nq_r1
