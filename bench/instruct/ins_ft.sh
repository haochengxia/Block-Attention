instruct_models="/work/hdd/bdjx/hxia3/models/llama-3.2/checkpoint-625"
name="llama-3.2-finetuned"

datasets="2wiki hqa tqa nq"
for im in $instruct_models; do
    for ds in $datasets; do
        echo "Run $name over $ds";
        echo "Run $name over $ds" >> temp_result_block;
        echo "Run $name over $ds" >> temp_result_full;
	python3 block_generate.py --model_name $im --input_file cache/${ds}_eval/dataset --output_file cache/benchmark/$name/${ds}_block;
	python3 eval.py --input cache/benchmark/$name/${ds}_block >> temp_result_block;
	python3 full_generate.py --model_name $im --input_file cache/${ds}_eval/dataset --output_file cache/benchmark/$name/${ds}_full;
	python3 eval.py --input cache/benchmark/$name/${ds}_full >> temp_result_full;
    done
done
