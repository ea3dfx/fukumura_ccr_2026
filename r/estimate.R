# Load required packages
library(estimate)

# Load normalized count matrix and compute estimate score
estimateScore("./preop_srs_trial_estimate_input.gct", 
              "./preop_srs_trial_estimate_score.gct", 
              platform = "illumina")
