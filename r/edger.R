# Load required packages
library(edgeR)  

# Define file paths (consider making these command-line arguments)
count_file <- "./featurecount_raw_counts.csv.gz"
metadata_file <- "./sample_til_grade.csv.gz"
output_file <- "./normalized_cts.csv"

# Load and prepare count matrix
cts <- read.csv("./featurecount_raw_counts.csv.gz", 
                row.names = 1,  # Use first column as row names directly
                check.names = FALSE,
                stringsAsFactors = FALSE)

# Load and prepare sample metadata
metadata <- read.csv("./sample_til_grade.csv.gz", 
                     stringsAsFactors = FALSE,
                     check.names = FALSE)
grade_mapping <- metadata$TIL.grade[match(colnames(cts), metadata$Sample.ID)]

# Create data frame with proper names
grade_df <- data.frame(sample_id = colnames(cts),
                       grade = factor(grade_mapping),
                       row.names = colnames(cts),
                       stringsAsFactors = FALSE)

# Normalize count data using edgeR's TMM method
y <- DGEList(counts = cts,
             group = grade_df$grade,
             genes = rownames(cts))
keep <- filterByExpr(y)
cat(paste("Keeping", sum(keep), "of", length(keep), "genes after filtering\n"))
y <- y[keep, , keep.lib.sizes = FALSE]
y <- calcNormFactors(y, method = "TMM")
normalized_cts <- cpm(y, log = TRUE, prior.count = 1)

# Export normalized counts to file
write.table(normalized.cts, 
            "./normalized_cts.csv", 
            row.names = FALSE,
            quote = FALSE)
