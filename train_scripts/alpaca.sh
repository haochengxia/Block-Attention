PROJECT_DIR="/projects/bdjx/hxia3/Block-Attention"

DS_CONFIG="${PROJECT_DIR}/configs/alpaca.json"

MODEL_NAME="meta-llama/Meta-Llama-3-8B" 
TRAIN_FP="cache/tqa_p10k"
EVAL_FP="cache/tqa_eval/dataset_20"
SAVE_DIR="model"

deepspeed --num_gpus 4 trainer.py \
  --model_name $MODEL_NAME \
  --train_fp $TRAIN_FP \
  --eval_fp $EVAL_FP \
  --train_method "block" \
  --train_prompt \
  --dataloader_num_workers 1 \
  --dataloader_prefetch_factor 8 \
  --do_train \
  --do_eval \
  --per_device_train_batch_size 1 \
  --per_device_eval_batch_size 1 \
  --gradient_accumulation_steps 2 \
  --learning_rate 2e-5 \
  --max_grad_norm 1.0 \
  --weight_decay 0.0 \
  --lr_scheduler_type "constant_with_warmup" \
  --evaluation_strategy "steps" \
  --optim "adamw_torch" \
  --eval_steps 200 \
  --warmup_steps 20 \
  --num_train_epochs 1 \
  --bf16 \
  --gradient_checkpointing \
  --output_dir $SAVE_DIR \
  --logging_dir $SAVE_DIR \
  --deepspeed $DS_CONFIG
