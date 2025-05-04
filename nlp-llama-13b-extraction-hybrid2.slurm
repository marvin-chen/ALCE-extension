#!/bin/bash
#SBATCH --job-name=nlp_test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G              # For Sphere corpus retrieval
#SBATCH --gres=gpu:1            # Request 1 A100 GPU
#SBATCH --constraint=gpu80      # Required for 80GB A100s
#SBATCH --time=03:00:00
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-type=fail         # send email if job fails
#SBATCH --mail-user=jl1543@princeton.edu
#SBATCH --output=nlp_test_%j.out

module purge
module load anaconda3/2024.10
conda activate alce
cd /scratch/gpfs/jl1543/ALCE-extension
 
export HF_HOME="/scratch/gpfs/jl1543/.cache"
export HF_DATASETS_CACHE="/scratch/gpfs/jl1543/.cache/huggingface/datasets"
export TRANSFORMERS_CACHE="$HF_HOME/hub"
export HF_HUB_OFFLINE=1
 
python run3.py --config configs/asqa_llama-13b_shot2_ndoc10_gtr_extraction_31_hybrid.yaml