instruct_models="meta-llama/Meta-Llama-3-8B-Instruct meta-llama/Llama-3.1-8B-Instruct"
datasets="2wiki hqa tqa nq"
for im in $instruct_models; do
    for ds in $datasets; do
        echo "Run $im over $ds";
        echo "Run $im over $ds" >> temp_result_pre;
	python3 preamble_block_generate.py --model_name $im --input_file cache/${ds}_eval/dataset --output_file cache/benchmark/$im/${ds}_pre;
	python3 eval.py --input cache/benchmark/$im/${ds}_pre >> temp_result_pre;
    done
done
