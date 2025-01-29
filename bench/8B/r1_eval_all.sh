files="cache/benchmark/block_2wiki_r1" 
for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
done


files="cache/benchmark/full_2wiki_r1"

for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
done

# ----------------------------------
files="cache/benchmark/block_hqa_r1"
for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_hqa;
    echo Finished $file...;
done


files="cache/benchmark/full_hqa_r1"

for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_hqa;
    echo Finished $file...;
done

files="cache/benchmark/block_tqa_r1"
for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
done


# for full manner

files="cache/benchmark/full_tqa_r1"

for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
done

# --------------------------------------

files="cache/benchmark/block_nq_r1"
for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_nq;
    echo Finished $file...;
done


files="cache/benchmark/full_nq_r1"

for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_nq;
    echo Finished $file...;
done