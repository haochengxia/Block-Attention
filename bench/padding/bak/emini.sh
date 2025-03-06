files="cache/benchmark/block_2wiki_instruct_0227_l31
cache/benchmark/block_2wiki_instruct_0227_l31_p" 
for file in $files; do
    echo Running $file...;
    python3 eval.py --input $file; # >> eval_wiki;
    echo Finished $file...;
done

