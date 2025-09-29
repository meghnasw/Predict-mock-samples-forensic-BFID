#!/usr/bin/env bash
set -eo pipefail

# >>> activate conda (adjust one of these to your install) <<<
#source "$HOME/miniconda3/etc/profile.d/conda.sh"
#source "$HOME/anaconda3/etc/profile.d/conda.sh"
eval "$($HOME/miniconda3/bin/conda shell.bash hook)" 

### Predict with QIIME2 ###
## Input files: 
# (1) OTU table: otu_table.qza (OTUs in rows and samples in columns)
# (2) Random forest classifier: sample_estimator.qza 

cd 04_QIIME2_predict/
conda init 
conda activate qiime2-amplicon-2024.5

biom convert -i QIIME2_otu_table_TSS.txt -o table_new_mock.biom --table-type="OTU table" --to-hdf5

qiime tools import --input-path table_new_mock.biom \
--type 'FeatureTable[Frequency]' \
--input-format BIOMV210Format \
--output-path otu_table.qza

qiime sample-classifier predict-classification \
--i-table otu_table.qza \
--i-sample-estimator ../Reference_files/sample_estimator.qza \
--o-predictions new_predictions.qza --o-probabilities new_probabilities.qza

qiime metadata tabulate --m-input-file new_predictions.qza --o-visualization new_predictions.qzv
	
qiime metadata tabulate --m-input-file new_probabilities.qza --o-visualization new_probabilities.qzv



