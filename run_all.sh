# for block manner
python3 block_generate.py --model_name meta-llama/Llama-3.2-1B-Instruct --input_file cache/2wiki_dev/dataset --output_file cache/benchmark/block_2wiki_instruct
python3 block_generate.py --model_name meta-llama/Llama-3.2-1B-Instruct --input_file cache/hqa_eval/dataset --output_file cache/benchmark/block_hqa_instruct

python3 block_generate.py --model_name meta-llama/Llama-3.2-1B --input_file cache/2wiki_dev/dataset --output_file cache/benchmark/block_2wiki_base
python3 block_generate.py --model_name meta-llama/Llama-3.2-1B --input_file cache/hqa_eval/dataset --output_file cache/benchmark/block_hqa_base

for step in "500 1000 1500 2000 2500 2596"; do
	echo Running checkpoint-$step...;
	python3 block_generate.py --model_name ./model/checkpoint-$step --input_file cache/2wiki_dev/dataset --output_file cache/benchmark/block_2wiki_checkpoint-$step
	python3 block_generate.py --model_name ./model/checkpoint-$step --input_file cache/hqa_eval/dataset --output_file cache/benchmark/block_hqa_checkpoint-$step
	echo Finished checkpoint-$step...;
done

# for full manner

python3 full_generate.py --model_name meta-llama/Llama-3.2-1B-Instruct --input_file cache/2wiki_dev/dataset --output_file cache/benchmark/full_2wiki_instruct
python3 full_generate.py --model_name meta-llama/Llama-3.2-1B-Instruct --input_file cache/hqa_eval/dataset --output_file cache/benchmark/full_hqa_instruct

python3 full_generate.py --model_name meta-llama/Llama-3.2-1B --input_file cache/2wiki_dev/dataset --output_file cache/benchmark/full_2wiki_base
python3 full_generate.py --model_name meta-llama/Llama-3.2-1B --input_file cache/hqa_eval/dataset --output_file cache/benchmark/full_hqa_base
