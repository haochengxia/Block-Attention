# for block manner
# python3 block_generate.py --model_name model/checkpoint-31 --input_file cache/2wiki_eval/dataset --output_file cache/benchmark/block_2wiki_checkpoint_31_l31
# python3 block_generate.py --model_name model/checkpoint-31 --input_file cache/hqa_eval/dataset --output_file cache/benchmark/block_hqa_checkpoint_31_l31
# python3 block_generate.py --model_name model/checkpoint-31 --input_file cache/tqa_eval/dataset --output_file cache/benchmark/block_tqa_checkpoint_31_l31
python3 block_generate.py --model_name model/checkpoint-31 --input_file cache/nq_eval/dataset --output_file cache/benchmark/block_nq_checkpoint_31_l31
# 
# files="cache/benchmark/block_2wiki_checkpoint_31_l31
# cache/benchmark/block_hqa_checkpoint_31_l31
# cache/benchmark/block_tqa_checkpoint_31_l31
# cache/benchmark/block_np_checkpoint_31_l31"
files="cache/benchmark/block_nq_checkpoint_31_l31"
for file in $files; do
echo $file;
python3 eval.py --input $file;
done;
