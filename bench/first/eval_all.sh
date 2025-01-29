files="cache/benchmark/block_2wiki_instruct_0123
cache/benchmark/block_2wiki_base_0123"
for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
done

steps="500 1000 1500 2000 2500 3000 3500 4000 4500"
for step in $steps; do
    file="cache/benchmark/block_2wiki_0123_checkpoint-$step"
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
done


files="cache/benchmark/full_2wiki_instruct_0123
cache/benchmark/full_2wiki_base_0123"

for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
done

# ----------------------------------
files="cache/benchmark/block_hqa_instruct_0123 
cache/benchmark/block_hqa_base_0123"
for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_hqa;
    echo Finished $file...;
done


steps="500 1000 1500 2000 2500 3000 3500 4000 4500"
for step in $steps; do
    file="cache/benchmark/block_hqa_0123_checkpoint-$step"
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_hqa;
    echo Finished $file...;
done

files="cache/benchmark/full_hqa_instruct_0123
cache/benchmark/full_hqa_base_0123"

for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_hqa;
    echo Finished $file...;
done
