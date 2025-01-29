
# for block manner
python3 block_generate.py --model_name meta-llama/Llama-3.2-1B-Instruct --input_file cache/tqa_eval/dataset --output_file cache/benchmark/block_tqa_instruct_0123
python3 block_generate.py --model_name meta-llama/Llama-3.2-1B-Instruct --input_file cache/nq_eval/dataset --output_file cache/benchmark/block_nq_instruct_0123

python3 block_generate.py --model_name meta-llama/Llama-3.2-1B --input_file cache/tqa_eval/dataset --output_file cache/benchmark/block_tqa_base_0123
python3 block_generate.py --model_name meta-llama/Llama-3.2-1B --input_file cache/nq_eval/dataset --output_file cache/benchmark/block_nq_base_0123

steps="500 1000 1500 2000 2500 3000 3500 4000 4500"
for step in $steps; do
	echo Running checkpoint-$step...;
	echo Running checkpoint-$step...;
	python3 block_generate.py --model_name ./model/checkpoint-$step --input_file cache/tqa_eval/dataset --output_file cache/benchmark/block_tqa_0123_checkpoint-$step
	python3 block_generate.py --model_name ./model/checkpoint-$step --input_file cache/nq_eval/dataset --output_file cache/benchmark/block_nq_0123_checkpoint-$step
	echo Finished checkpoint-$step...;
done

# for full manner

python3 full_generate.py --model_name meta-llama/Llama-3.2-1B-Instruct --input_file cache/tqa_eval/dataset --output_file cache/benchmark/full_tqa_instruct_0123
python3 full_generate.py --model_name meta-llama/Llama-3.2-1B-Instruct --input_file cache/nq_eval/dataset --output_file cache/benchmark/full_nq_instruct_0123

python3 full_generate.py --model_name meta-llama/Llama-3.2-1B --input_file cache/tqa_eval/dataset --output_file cache/benchmark/full_tqa_base_0123
python3 full_generate.py --model_name meta-llama/Llama-3.2-1B --input_file cache/nq_eval/dataset --output_file cache/benchmark/full_nq_base_0123

