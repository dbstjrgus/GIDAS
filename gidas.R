library(ggplot2)
library(dplyr)
library(tidyr)
library(pheatmap)

ADBrain <- read.csv("/Users/25yoon/PycharmProjects/rstuff/GIDAS2025 copy_ADBrainPathways.csv")
ADCell <- read.csv("/Users/25yoon/PycharmProjects/rstuff/GIDAS2025 copy_ADCellPathways.csv")
MS <- read.csv("/Users/25yoon/PycharmProjects/rstuff/GIDAS2025 copy_MSPathways.csv")

# Count pathways per disease
ad_pathways_brain <- unique(ADBrain$Term)
ad_pathways_cell <- unique(ADCell$Term)

ad_pathways <- unique(c(ADBrain$Term, ADCell$Term))
ms_pathways <- unique(MS$Term)

# Find shared and unique pathways
shared_pathways <- intersect(ad_pathways, ms_pathways)
unique_ad_pathways <- setdiff(ad_pathways, ms_pathways)
unique_ms_pathways <- setdiff(ms_pathways, ad_pathways)

# Summary
length(shared_pathways)  # Common pathways
length(unique_ad_pathways)  # Unique to AD
length(unique_ms_pathways) # Unique to MS

#this df has only shared pathways
shared_pathways <- merge(ADCell, ADBrain, MS, by = "Term", suffixes = c("_ADC", "_ADB", "_MS"))
# this has everything
all_pathways <- merge(ADCell, ADBrain, MS, by = "Term", suffixes = c("_ADC", "_ADB", "_MS"), all = TRUE)





