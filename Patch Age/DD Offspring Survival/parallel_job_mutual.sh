#! /bin/bash   
#SBATCH --job-name="DDRecUpdated"
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --mem-per-cpu=5000m
#SBATCH --cpus-per-task=1
#SBATCH --time=48:00:00
#SBATCH --account="Aostling0"
#SBATCH --partition=standard
#SBATCH --array=1-4



module purge
module load matlab

matlab -r "MutualInvasionSweepParallel ; exit"