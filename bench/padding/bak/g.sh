python3 block_generate.py --model_name meta-llama/Llama-3.1-8B-Instruct --input_file cache/2wiki_eval/dataset --output_file cache/benchmark/block_2wiki_instruct_0227_l31
python3 block_generate.py --model_name meta-llama/Llama-3.1-8B-Instruct --input_file cache/hqa_eval/dataset --output_file cache/benchmark/block_hqa_instruct_0227_l31
python3 block_generate.py --model_name meta-llama/Llama-3.1-8B-Instruct --input_file cache/tqa_eval/dataset --output_file cache/benchmark/block_tqa_instruct_0227_l31
python3 block_generate.py --model_name meta-llama/Llama-3.1-8B-Instruct --input_file cache/nq_eval/dataset --output_file cache/benchmark/block_nq_instruct_0227_l31

python3 block_generate_padding.py --model_name meta-llama/Llama-3.1-8B-Instruct --input_file cache/2wiki_eval/dataset --output_file cache/benchmark/block_2wiki_instruct_0227_l31_p
python3 block_generate_padding.py --model_name meta-llama/Llama-3.1-8B-Instruct --input_file cache/hqa_eval/dataset --output_file cache/benchmark/block_hqa_instruct_0227_l31_p
python3 block_generate_padding.py --model_name meta-llama/Llama-3.1-8B-Instruct --input_file cache/tqa_eval/dataset --output_file cache/benchmark/block_tqa_instruct_0227_l31_p
python3 block_generate_padding.py --model_name meta-llama/Llama-3.1-8B-Instruct --input_file cache/nq_eval/dataset --output_file cache/benchmark/block_nq_instruct_0227_l31_p
