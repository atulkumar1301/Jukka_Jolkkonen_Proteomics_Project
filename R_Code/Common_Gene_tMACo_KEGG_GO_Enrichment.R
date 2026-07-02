library(data.table)
library(tidyverse)
library(clusterProfiler)
library(org.Mm.eg.db)
library(enrichplot)

# 1. Load data
common_data <- fread("~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/Common_tMCAo.txt")
shared_genes <- common_data$`Gene names`

# Convert to Entrez IDs
gene_ids <- bitr(shared_genes, fromType = "SYMBOL", toType = "ENTREZID", OrgDb = org.Mm.eg.db)

# 2. Run GO Enrichment (Combining BP and CC ontologies)
go_enrich <- enrichGO(
  gene          = gene_ids$ENTREZID,
  OrgDb         = org.Mm.eg.db,
  ont           = "ALL",           # Searches Biological Process & Cellular Component
  pvalueCutoff  = 0.05,
  pAdjustMethod = "BH",
  readable      = TRUE
)

# 3. Save the crisp GO dotplot (Fixes the empty plot issue)
# If adjusted p-values are too strict, we display by raw p-value to capture the trends
pdf("~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/FigureS3_Shared_GO_Enrichment.pdf", width = 8, height = 6)

if(!is.null(go_enrich) && nrow(as.data.frame(go_enrich)) > 0) {
  print(dotplot(go_enrich, showCategory = 10, split="ONTOLOGY") + 
          facet_grid(ONTOLOGY~., scales="free") +
          theme_minimal(base_family = "serif") +
          labs(title = "GO Enrichment of Shared Proteome"))
} else {
  # Fallback option if adjusted p-values yield nothing: use unadjusted p-value cutoff
  go_enrich_fallback <- enrichGO(gene = gene_ids$ENTREZID, OrgDb = org.Mm.eg.db, ont = "ALL", pvalueCutoff = 0.05, pAdjustMethod = "none", readable = TRUE)
  print(dotplot(go_enrich_fallback, showCategory = 10, split="ONTOLOGY") + 
          facet_grid(ONTOLOGY~., scales="free") +
          theme_minimal(base_family = "serif") +
          labs(title = "GO Enrichment of Shared Proteome (p-value unadjusted)"))
}

dev.off()

# Convert the R enrichment object directly into a clean data frame
go_table_df <- as.data.frame(go_enrich)

# View the top results in a table format inside RStudio
View(go_table_df)

# Export the table as a tab-separated text file to open in Excel
write.table(go_table_df, "~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/Shared_GO_Enrichment_Table.txt", 
            sep="\t", quote=FALSE, row.names=FALSE)
