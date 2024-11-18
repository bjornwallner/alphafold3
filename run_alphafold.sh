#!/bin/bash
#SBATCH --gpus 1
#SBATCH -t 720 
##SBATCH -A berzelius-2024-221
#SBATCH -A berzelius-2024-256
##SBATCH -A berzelius-2023-417 
AF_PATH='/proj/wallner-b/apps/alphafold3/'
export PATH=/proj/wallner-b/apps/hmmer-3.4/bin/:$PATH

module load Mambaforge/23.3.1-1-hpc1-bdist
#module load buildenv-gcccuda/12.1.1-gcc12.3.0
module load buildenv-nvhpc/24.5-cuda12.4 #buildenv-nvhpc/23.7-cuda12.2
#CHECK WITHOUT SETTING PATH
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/software/sse/manual/CUDA/12.1.1_530.30.02/lib64/

#OLD SETTINGS
#export XLA_FLAGS=--xla_gpu_cuda_data_dir=$CUDA_PATH
#export TF_FORCE_UNIFIED_MEMORY=1
#export XLA_PYTHON_CLIENT_MEM_FRACTION=10.0

#SETTING CUDA_PATH
export XLA_FLAGS="--xla_gpu_enable_triton_gemm=false --xla_gpu_cuda_data_dir=${CUDA_PATH}"
#export XLA_FLAGS="--xla_gpu_enable_triton_gemm=false"
# Memory settings used for folding up to 5,120 tokens on A100 80 GB.
export XLA_PYTHON_CLIENT_PREALLOCATE=true
export XLA_CLIENT_MEM_FRACTION=0.95

conda activate /proj/wallner-b/users/x_bjowa/.conda/envs/alphafold3/
which python
echo $CUDA_PATH
module list
which ptx
which nvidia-smi
nvidia-smi
date
echo Running CMD: python $AF_PATH/run_alphafold.py $@
python $AF_PATH/run_alphafold.py $@
date