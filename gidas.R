library(ggplot2)
library(dplyr)
library(tidyr)

ADBrain <- read.csv("/Users/25yoon/PycharmProjects/rstuff/GIDAS2025 copy_ADBrainPathways.csv")
ADCell <- read.csv("/Users/25yoon/PycharmProjects/rstuff/GIDAS2025 copy_ADCellPathways.csv")
MS <- read.csv("/Users/25yoon/PycharmProjects/rstuff/GIDAS2025 copy_MSPathways.csv")

ad_pathways <- unique(c(ADBrain$Term, ADCell$Term))
ms_pathways <- unique(MS$Term)

# Find shared and unique pathways
shared_pathways <- intersect(ad_pathways, ms_pathways)
unique_ad_pathways <- setdiff(ad_pathways, ms_pathways)
unique_ms_pathways <- setdiff(ms_pathways, ad_pathways)
length(shared_pathways)  # Common pathways
length(unique_ad_pathways)  # Unique to AD
length(unique_ms_pathways) # Unique to MS

#this df has only shared pathways
#shared_pathways <- merge(ADCell, ADBrain, MS, by = "Term", suffixes = c("_ADC", "_ADB", "_MS"))
# this has everything
#all_pathways <- merge(ADCell, ADBrain, MS, by = "Term", suffixes = c("_ADC", "_ADB", "_MS"), all = TRUE)


all_pathways <- bind_rows(
  ADBrain %>% mutate(Disease = "AD_Brain"),
  ADCell %>% mutate(Disease = "AD_Cell"),
  MS %>% mutate(Disease = "MS")
)

all_genes <- all_pathways %>%
  separate_rows(Genes, sep = ",") %>%  # Replace "," with the appropriate delimiter
  rename(Gene = Genes) %>%             # Rename the column to "Gene"
  na.omit()

gene_frequencies <- all_genes %>%
  group_by(Disease, Gene) %>%
  summarise(Count = n(), .groups = 'drop') %>%
  arrange(Disease, desc(Count))

# Filter top N genes for each disease
top_genes <- gene_frequencies %>%
  group_by(Disease) %>%
  slice_max(Count, n = 10)  # Adjust `n` to show more or fewer genes

# Create a bar plot
ggplot(top_genes, aes(x = reorder(Gene, Count), y = Count, fill = Disease)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ Disease, scales = "free") +
  coord_flip() +
  labs(title = "Top Genes in Alzheimer's and Multiple Sclerosis Pathways",
       x = "Gene",
       y = "Frequency") +
  theme_minimal()




