files="cache/benchmark/block_2wiki_instruct_0126_l32
cache/benchmark/block_2wiki_base_0126_l32" 
for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
done


files="cache/benchmark/full_2wiki_instruct_0126_l32
cache/benchmark/full_2wiki_base_0126_l32"

for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
done

# ----------------------------------
files="cache/benchmark/block_hqa_instruct_0126_l32 
cache/benchmark/block_hqa_base_0126_l32"
for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_hqa;
    echo Finished $file...;
done


files="cache/benchmark/full_hqa_instruct_0126_l32
cache/benchmark/full_hqa_base_0126_l32"

for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_hqa;
    echo Finished $file...;
done

files="cache/benchmark/block_tqa_instruct_0126_l32
cache/benchmark/block_tqa_base_0126_l32"
for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
done

# for full manner

files="cache/benchmark/full_tqa_instruct_0126_l32
cache/benchmark/full_tqa_base_0126_l32"

for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
done

# --------------------------------------

files="cache/benchmark/block_nq_instruct_0126_l32 
cache/benchmark/block_nq_base_0126_l32"
for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_nq;
    echo Finished $file...;
done

files="cache/benchmark/full_nq_instruct_0126_l32
cache/benchmark/full_nq_base_0126_l32"

for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_nq;
    echo Finished $file...;
done