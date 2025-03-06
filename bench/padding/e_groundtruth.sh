
for dataset in 2wiki tqa hqa nq
do
    echo "############ dataset: ${dataset}"
    # without padding
    # file=cache/benchmark/full_${dataset}_instruct_0228_l31
    # echo Running $file...;
    # python3 eval.py --input $file; # >> eval_wiki;
    # echo Finished $file...;


    # with padding
    for padding_size in 16 32 64
    do
        file=cache/benchmark/full_${dataset}_instruct_0228_l31_p_${padding_size}
        echo Running $file...;
        python3 eval.py --input $file; # >> eval_wiki;
        echo Finished $file...;
    done
done