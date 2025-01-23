files="cache/benchmark/block_tqa_instruct 
cache/benchmark/block_tqa_base"
for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
done

files="cache/benchmark/block_nq_instruct 
cache/benchmark/block_nq_base"
for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_nq;
    echo Finished $file...;
done

steps="500 1000 1500 2000 2500 3000 3500 4000 4500"
for step in $steps; do
    file="cache/benchmark/block_tqa_checkpoint-$step"
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
    file="cache/benchmark/block_nq_checkpoint-$step"
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_nq;
    echo Finished $file...;
done

# for full manner

files="cache/benchmark/full_tqa_instruct
cache/benchmark/full_tqa_base"

for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
done


files="cache/benchmark/full_nq_instruct
cache/benchmark/full_nq_base"

for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_nq;
    echo Finished $file...;
done
