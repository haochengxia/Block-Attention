num=50

for dataset in 2wiki # tqa hqa nq
do
    echo "dataset: ${dataset}"
    # without padding
    # python3 block_generate.py --num ${num} --model_name ldsjmdy/Tulu3-Block-FT --input_file cache/${dataset}_eval/dataset --output_file cache/benchmark/block_attention_${dataset}_instruct
    python3 eval.py --input cache/benchmark/block_attention_${dataset}_instruct
done