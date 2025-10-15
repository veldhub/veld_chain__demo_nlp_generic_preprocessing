#!/bin/bash

#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=5GB
#SBATCH --time=00:05:00
#SBATCH --qos=rapid
#SBATCH --output=/users/stefan.resch/veld/veld_chain__demo_nlp_generic_preprocessing/veld_demo_apptainer.log

title="veld_chain__demo_nlp"

ntfy "${title}: start"

apptainer-compose -f veld_demo_7_change_case.yaml up

ntfy "${title}: end"

