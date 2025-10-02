# Predict mock samples
1) A toy dataset: Since the classifier was trained on OTUs clustered at 97%, it is best to process the case samples/mock samples in the same way as the classifier. The attachment covers all these steps and the toy dataset of 10 samples should give you concrete examples on how the input files should look like for each step. Please note that the toy dataset is really only for demonstration purposes and it is a subset of the training data. 

Please note that the toy dataset provided solely for demonstration purposes. This dataset is a subset of the training data, and therefore any results obtained from it should not be interpreted as meaningful, as the samples were already used during model training. 

2) The main script: Follow the R markdown file in: scripts/Predict_mock_or_case_samples.Rmd. You can simply run each chunk with the green arrow on the upper right side of the chunks in RStudio. This script calls onto two bash scripts: one that does the OTU clustering at 97% and the other that actually does the predictions. You can also just follow the  scripts/Prediction_QIIME2.sh file if you only want to only run the prediction step. 

3) Classifier:

Includes data from V3V4, V4 and V4V5 regions and data from 7 body fluids/tissues (Fecal, Saliva, Semen, Skin-penile, Skin-hand, Urine and Vaginal swab). 
Vaginal swab category includes data from vaginal fluid and menstrual blood. 
Total 366 samples

Where to plug in your files:

Please note that you would have to run the DADA2 pipeline on your case samples first and then follow the R markdown. You would need to replace the following with your files and run the markdown:

    - 01_DADA2/seqtab_nochim.rdata # DADA2 output
    - metadata/map.txt # Metadata
