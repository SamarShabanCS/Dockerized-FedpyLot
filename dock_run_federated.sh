#!/bin/bash
# FedPylot by Cyprien Quéméneur, GPL-3.0 license
# Example usage: sbatch run_federated.sh

#SBATCH --nodes=11                       # total number of nodes (1 server and 10 client nodes)
#SBATCH --gpus-per-node=v100l:1          # total of 11 GPUs
#SBATCH --ntasks-per-gpu=1               # 1 MPI process is launched per node
#SBATCH --cpus-per-task=8                # CPU cores per MPI process
#SBATCH --mem-per-cpu=2G                 # host memory per CPU core
#SBATCH --time=0-12:00:00                # time (DD-HH:MM:SS)
#SBATCH --mail-user=myemail@gmail.com    # receive mail notifications
#SBATCH --mail-type=ALL

# Check GPU on orchestrating node
#nvidia-smi

# Load modules
#module purge
#module load python/3.9.6 scipy-stack
#module load openmpi/4.0.3
#module load gcc/9.3.0
#module load opencv/4.6.0
#module load mpi4py

# Load pre-existing virtual environment
#source ~/venv-py39-fl/bin/activate
echo "Current directory: $(pwd)"
start_path=$(pwd)
# Prepare directory to backup results
saving_path=$(pwd)/results/nuimages10/yolov7/fedoptm
mkdir -p $saving_path

# Transmit all files besides the datasets and results directories to the local storage of the compute nodes
#srun rsync -a --exclude="datasets" --exclude="results" ../fedpylot $SLURM_TMPDIR (should not count this transfer time into considerations as it supposed that the data is already distributed)

# Create an empty directory on the compute nodes local storage to receive their respective local dataset
#srun mkdir -p $SLURM_TMPDIR/fedpylot/datasets/nuimages10
#mkdir -p $SLURM_TMPDIR/fedpylot/datasets/nuimages10
CURRENT_DIR=$start_path
#$CURRENT_DIR = $(pwd)
# Transfer the local datasets from the network storage to the local storage of the compute nodes
#export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
#srun --cpus-per-task=$SLURM_CPUS_PER_TASK 
#mpiexec --allow-run-as-root -n 3 -machinefile ~/machinefile python -m mpi4py federated/scatter_data.py --dataset nuimages10
mpiexec --allow-run-as-root -n 11 -machinefile ~/machinefile python -m mpi4py federated/scatter_data.py --cPATH $CURRENT_DIR --dataset nuimages10

# Move to local storage
#cd $SLURM_TMPDIR/fedpylot
#CURRENT_DIR=$start_path
#cd $CURRENT_DIR
#cho "Current directory: $(pwd)"

#cd $CURRENT_DIR
echo "Current directory after command cd CURRENT_DIR returnning drom scatter script : $(pwd)"

# Download pre-trained weights on the orchestrating node (i.e. the server)
bash weights/get_weights.sh yolov7

# Run federated learning experiment (see main.py for more details on the settings)
#export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
#srun --cpus-per-task=$SLURM_CPUS_PER_TASK python federated/main.py \ #mpiexec
echo "Current directory after downloading pretrained weights: $(pwd)"
mpiexec  -n 11 --allow-run-as-root  -machinefile ~/machinefile python -m mpi4py federated/main.py \
    --nrounds 2 \
    --epochs 2 \
    --server-opt fedavgm \
    --server-lr 1.0 \
    --beta 0.1 \
    --architecture yolov7 \
    --weights weights/yolov7/yolov7_training.pt \
    --data data/nuimages10.yaml \
    --bsz-train 32 \
    --bsz-val 32 \
    --img 640 \
    --conf 0.001 \
    --iou 0.65 \
    --cfg yolov7/cfg/training/yolov7.yaml \
    --hyp data/hyps/hyp.scratch.clientopt.nuimages.yaml \
    --workers 8

# Backup experiment results to network storage
cp -r ./experiments $saving_path
