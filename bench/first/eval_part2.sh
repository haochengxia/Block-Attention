files="cache/benchmark/block_tqa_instruct_0123
cache/benchmark/block_tqa_base_0123"
for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
done

steps="500 1000 1500 2000 2500 3000 3500 4000 4500"
for step in $steps; do
    file="cache/benchmark/block_tqa_0123_checkpoint-$step"
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
done

# for full manner

files="cache/benchmark/full_tqa_instruct_0123
cache/benchmark/full_tqa_base_0123"

for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
done

# --------------------------------------

files="cache/benchmark/block_nq_instruct_0123 
cache/benchmark/block_nq_base_0123"
for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_nq;
    echo Finished $file...;
done

steps="500 1000 1500 2000 2500 3000 3500 4000 4500"
for step in $steps; do
    file="cache/benchmark/block_nq_0123_checkpoint-$step"
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_nq;
    echo Finished $file...;
done

files="cache/benchmark/full_nq_instruct_0123
cache/benchmark/full_nq_base_0123"

for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_nq;
    echo Finished $file...;
done
