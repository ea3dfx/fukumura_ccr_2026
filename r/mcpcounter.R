# Load required packages
library(MCPcounter)

# Load normalized count matrix and compute MCPcounter estimate score
normalized_cts <- read.csv("./normalized_cts.csv", 
                     stringsAsFactors = FALSE,
                     check.names = FALSE)
mcp.results <- MCPcounter.estimate(normalized_cts, 
                                   featuresType = "ENSEMBL_ID")

# Export normalized counts to file
write.table(mcp.results, 
            "./mcp_results.csv", 
            row.names = FALSE,
            quote = FALSE)
