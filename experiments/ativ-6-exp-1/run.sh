#!/usr/bin/env bash

BATCH_SIZE=16
PROC=2
EPOCHS=1
NODES=2
RANK=0
MASTER_IP="172.17.0.1"
PORT="1234"

cd ../..

./experiments/ativ-6-exp-1/download_dataset.sh

docker build -t dist_dcgan .

docker run --user=$(id -u):$(id -g) --env OMP_NUM_THREADS=1 --rm --network=host -v=$(pwd):/root dist_dcgan:latest python -m torch.distributed.launch --nproc_per_node=$PROC --nnodes=$NODES --node_rank=$RANK --master_addr=$MASTER_IP --master_port=$PORT dist_dcgan.py --dataset cifar10 --dataroot ./cifar10 --batch_size=$BATCH_SIZE --num_epochs=$EPOCHS
