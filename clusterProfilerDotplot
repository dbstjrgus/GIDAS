# Load necessary libraries
library(clusterProfiler)
library(ggplot2)
library(readxl)
library(DOSE)  # For disease ontology analysis (optional)
library(enrichplot)  # For visualization

# Load DAVID results from Excel
david_data <- ADBrain_Pathways

# Preview data
head(david_data)

# Ensure the dataset has the required columns
# Assume columns from DAVID: "GO.ID", "Term", "Count", "Pop.Hits", "Pop.Total", "FDR"

# Format data for clusterProfiler
enrich_df <- data.frame(
  ID = david_data$Term,  # GO Term ID
  Description = david_data$Term,  # GO Term Name
  GeneRatio = david_data$'%'/100,  # Convert to fraction
  BgRatio = paste(david_data$'Pop Hits', "/", david_data$'Pop Total', sep=""),
  p.adjust = david_data$PValue,  # Adjusted p-value (FDR)
  Count = david_data$Count  # Gene count
)

# Convert to enrichResult object
enrich_obj <- new("enrichResult",
                  result = enrich_df,
                  organism = "human",
                  keytype = "ENTREZID",
                  pvalueCutoff = 0.05,
                  pAdjustMethod = "BH",
                  qvalueCutoff = 0.2)

# Ensure Count is numeric
enrich_df$Count <- as.numeric(enrich_df$Count)

# Create a `compareClusterResult` object manually
compare_obj <- new("compareClusterResult",
                   compareClusterResult = enrich_df,
                   fun = "enrichGO")

# Generate dot plot
dotplot(compare_obj, showCategory = 20) + ggtitle("GO Enrichment Dot Plot")
