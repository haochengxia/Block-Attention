num=1000

# for dataset in 2wiki tqa hqa nq
# do
#     echo "dataset: ${dataset}"
#     # without padding
#     python3 block_generate.py --num ${num} --model_name meta-llama/Llama-3.1-8B-Instruct --input_file cache/${dataset}_eval/dataset --output_file cache/benchmark/block_${dataset}_instruct_0228_l31


#     # with padding
#     for padding_size in 16
#     do
#         echo "padding_size: ${padding_size}"
#         python3 block_generate_padding.py --num ${num} --model_name meta-llama/Llama-3.1-8B-Instruct --input_file cache/${dataset}_eval/dataset --output_file cache/benchmark/block_${dataset}_instruct_0228_l31_p_${padding_size}
#     done
# done


for dataset in 2wiki tqa hqa nq
do
    echo "dataset: ${dataset}"
    # with padding
    for padding_size in 32 64   
    do
        echo "padding_size: ${padding_size}"
        python3 block_generate_padding.py --num ${num} --model_name meta-llama/Llama-3.1-8B-Instruct --input_file cache/${dataset}_eval/dataset --output_file cache/benchmark/block_${dataset}_instruct_0228_l31_p_${padding_size}
    done
done
