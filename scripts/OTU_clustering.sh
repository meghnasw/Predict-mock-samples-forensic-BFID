#!/usr/bin/env bash
set -eo pipefail

# >>> activate conda (adjust one of these to your install) <<<
#source "$HOME/miniconda3/etc/profile.d/conda.sh"
#source "$HOME/anaconda3/etc/profile.d/conda.sh"
eval "$($HOME/miniconda3/bin/conda shell.bash hook)" 

## Cluster into OTUs at 97% 

cd 02_QIIME2_otu_clustering/
conda init 
conda activate qiime2-amplicon-2024.5

## Import the ASV sequences into QIIME2

qiime tools import --input-path ../01_DADA2/rep-seqs.fna --type 'FeatureData[Sequence]' --output-path rep-seqs.qza

## Import the ASV table into QIIME2
biom convert -i ../01_DADA2/seqtab_nochim_internalDb.txt -o table_new.biom --table-type="OTU table" --to-hdf5

qiime tools import --input-path table_new.biom --type 'FeatureTable[Frequency]' --input-format BIOMV210Format --output-path ASV_qza_table.qza

## OTU clustering against the silva database
qiime vsearch cluster-features-closed-reference --i-table ASV_qza_table.qza \
	--i-sequences rep-seqs.qza \
		--i-reference-sequences ../Reference_files/silva-138-ssu-nr99-seqs-derep-uniq-97.qza \
			--p-perc-identity 0.97 \
				--o-clustered-table table-cr-97.qza \
					--o-clustered-sequences rep-seqs-cr-97.qza \
						--o-unmatched-sequences unmatched-cr-97.qza

## Save outputs and conver the OTU table into a .tsv for the next steps in R
qiime tools export --input-path table-cr-97.qza --output-path exported-OTU-table/ 
biom convert -i exported-OTU-table/feature-table.biom -o OTU-cr_97_table.tsv --to-tsv


