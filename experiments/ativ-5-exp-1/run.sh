#!/usr/bin/env bash

BATCH_SIZE=32
PROCS=(1 2 4 8)
EPOCHS=1
REPEAT=3

cd ../..

./experiments/ativ-5-exp-1/download_dataset.sh

docker build -t dist_dcgan .

for PROC in "${PROCS[@]}"
do
  for ((i=0; i < REPEAT; i++))
  do
    echo "CIFAR-10 DCGAN batch:$BATCH procs:$PROC epochs:$EPOCHS run:$i"
    time -p docker run --user=$(id -u):$(id -g) --env OMP_NUM_THREADS=1 --rm --network=host -v=$(pwd):/root dist_dcgan:latest python -m torch.distributed.launch --nproc_per_node=$PROC --nnodes=1 --node_rank=0 --master_addr="172.17.0.1" --master_port=1234 dist_dcgan.py --dataset cifar10 --dataroot ./cifar10 --batch_size=$BATCH_SIZE --num_epochs=$EPOCHS
  done
done

