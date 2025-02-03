instruct_models="meta-llama/Meta-Llama-3-8B-Instruct meta-llama/Llama-3.1-8B-Instruct"
datasets="2wiki hqa tqa nq"
for im in $instruct_models; do
    for ds in $datasets; do
        echo "Run $im over $ds";
        echo "Run $im over $ds" >> temp_result_block;
        echo "Run $im over $ds" >> temp_result_full;
	python3 block_generate.py --model_name $im --input_file cache/${ds}_eval/dataset --output_file cache/benchmark/$im/${ds}_block;
	python3 eval.py --input cache/benchmark/$im/${ds}_block >> temp_result_block;
	python3 full_generate.py --model_name $im --input_file cache/${ds}_eval/dataset --output_file cache/benchmark/$im/${ds}_full;
	python3 eval.py --input cache/benchmark/$im/${ds}_full >> temp_result_full;
    done
done
