#!/bin/bash
#SBATCH --job-name=nlp_test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6       # Match Adroit’s 36-core nodes (6 cores per GPU task)
#SBATCH --mem=128G              # For Sphere corpus retrieval
#SBATCH --gres=gpu:1            # Request 1 A100 GPU
#SBATCH --constraint=gpu80      # Required for 80GB A100s
#SBATCH --time=00:30:00
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-type=fail         # send email if job fails
#SBATCH --mail-user=mh9610@princeton.edu
#SBATCH --output=nlp_test_%j.out

module load anaconda3/2024.2
source /usr/licensed/anaconda3/2024.2/etc/profile.d/conda.sh 
conda activate alce
cd /scratch/network/mh9610/cos484/ALCE-extension

export HF_HOME="/scratch/network/$USER/.cache/huggingface"
export HF_DATASETS_CACHE="/scratch/network/$USER/.cache/huggingface/datasets"
export TRANSFORMERS_CACHE="$HF_HOME/hub"
export HF_HUB_OFFLINE=0

python eval.py --f /results/asqa-opt-6.7b-gtr-shot1-ndoc3-42-quick_test3.json --citations --qa --no_rouge 