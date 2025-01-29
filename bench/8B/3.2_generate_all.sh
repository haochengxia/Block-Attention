# for block manner
python3 block_generate.py --model_name meta-llama/Llama-3.2-3B-Instruct --input_file cache/2wiki_eval/dataset --output_file cache/benchmark/block_2wiki_instruct_0126_l32
python3 block_generate.py --model_name meta-llama/Llama-3.2-3B-Instruct --input_file cache/hqa_eval/dataset --output_file cache/benchmark/block_hqa_instruct_0126_l32
python3 block_generate.py --model_name meta-llama/Llama-3.2-3B-Instruct --input_file cache/tqa_eval/dataset --output_file cache/benchmark/block_tqa_instruct_0126_l32
python3 block_generate.py --model_name meta-llama/Llama-3.2-3B-Instruct --input_file cache/nq_eval/dataset --output_file cache/benchmark/block_nq_instruct_0126_l32

python3 block_generate.py --model_name meta-llama/Llama-3.2-3B --input_file cache/2wiki_eval/dataset --output_file cache/benchmark/block_2wiki_base_0126_l32
python3 block_generate.py --model_name meta-llama/Llama-3.2-3B --input_file cache/hqa_eval/dataset --output_file cache/benchmark/block_hqa_base_0126_l32
python3 block_generate.py --model_name meta-llama/Llama-3.2-3B --input_file cache/tqa_eval/dataset --output_file cache/benchmark/block_tqa_base_0126_l32
python3 block_generate.py --model_name meta-llama/Llama-3.2-3B --input_file cache/nq_eval/dataset --output_file cache/benchmark/block_nq_base_0126_l32

# for full manner

python3 full_generate.py --model_name meta-llama/Llama-3.2-3B-Instruct --input_file cache/2wiki_eval/dataset --output_file cache/benchmark/full_2wiki_instruct_0126_l32
python3 full_generate.py --model_name meta-llama/Llama-3.2-3B-Instruct --input_file cache/hqa_eval/dataset --output_file cache/benchmark/full_hqa_instruct_0126_l32
python3 full_generate.py --model_name meta-llama/Llama-3.2-3B-Instruct --input_file cache/tqa_eval/dataset --output_file cache/benchmark/full_tqa_instruct_0126_l32
python3 full_generate.py --model_name meta-llama/Llama-3.2-3B-Instruct --input_file cache/nq_eval/dataset --output_file cache/benchmark/full_nq_instruct_0126_l32

python3 full_generate.py --model_name meta-llama/Llama-3.2-3B --input_file cache/2wiki_eval/dataset --output_file cache/benchmark/full_2wiki_base_0126_l32
python3 full_generate.py --model_name meta-llama/Llama-3.2-3B --input_file cache/hqa_eval/dataset --output_file cache/benchmark/full_hqa_base_0126_l32
python3 full_generate.py --model_name meta-llama/Llama-3.2-3B --input_file cache/tqa_eval/dataset --output_file cache/benchmark/full_tqa_base_0126_l32
python3 full_generate.py --model_name meta-llama/Llama-3.2-3B --input_file cache/nq_eval/dataset --output_file cache/benchmark/full_nq_base_0126_l32
