#!/bin/bash -l
#SBATCH -J qa_uvfits
#SBATCH -o qa_fits-%A-%a.out
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=00:30:00
#SBATCH --account=oz048
#SBATCH --export=NONE
#SBATCH --mem=30000
#SBATCH --cpus-per-task=2
#SBATCH --partition=skylake
#SBATCH --mem=30000

cd $SLURM_SUBMIT_DIR

obsid_file=${1}
while read line
do
   obs_array+=(${line})
done < ${obsid_file}
#./pipeline_qa_uvfits.py ${obs_array[${SLURM_ARRAY_TASK_ID}-1]} --subdir=low_zenith_avg
srun --export=ALL --mem=30000 python /fred/oz048/bpindor/RTS_Python/uvfits_qa/pipeline_qa_uvfits.py ${obs_array[${SLURM_ARRAY_TASK_ID}-1]} --subdir=${2} --nbands=20
