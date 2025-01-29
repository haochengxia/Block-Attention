# for block manner
python3 block_generate.py --model_name meta-llama/Llama-3.2-1B-Instruct --input_file cache/2wiki_eval/dataset --output_file cache/benchmark/block_2wiki_instruct_0123
python3 block_generate.py --model_name meta-llama/Llama-3.2-1B-Instruct --input_file cache/hqa_eval/dataset --output_file cache/benchmark/block_hqa_instruct_0123

python3 block_generate.py --model_name meta-llama/Llama-3.2-1B --input_file cache/2wiki_eval/dataset --output_file cache/benchmark/block_2wiki_base_0123
python3 block_generate.py --model_name meta-llama/Llama-3.2-1B --input_file cache/hqa_eval/dataset --output_file cache/benchmark/block_hqa_base_0123

steps="500 1000 1500 2000 2500 3000 3500 4000 4500"
for step in $steps; do
	echo Running checkpoint-$step...;
	echo Running checkpoint-$step...;
	python3 block_generate.py --model_name ./model/checkpoint-$step --input_file cache/2wiki_eval/dataset --output_file cache/benchmark/block_2wiki_0123_checkpoint-$step
	python3 block_generate.py --model_name ./model/checkpoint-$step --input_file cache/hqa_eval/dataset --output_file cache/benchmark/block_hqa_0123_checkpoint-$step
	echo Finished checkpoint-$step...;
done

# for full manner

python3 full_generate.py --model_name meta-llama/Llama-3.2-1B-Instruct --input_file cache/2wiki_eval/dataset --output_file cache/benchmark/full_2wiki_instruct_0123
python3 full_generate.py --model_name meta-llama/Llama-3.2-1B-Instruct --input_file cache/hqa_eval/dataset --output_file cache/benchmark/full_hqa_instruct_0123

python3 full_generate.py --model_name meta-llama/Llama-3.2-1B --input_file cache/2wiki_eval/dataset --output_file cache/benchmark/full_2wiki_base_0123
python3 full_generate.py --model_name meta-llama/Llama-3.2-1B --input_file cache/hqa_eval/dataset --output_file cache/benchmark/full_hqa_base_0123
