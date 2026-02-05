library(clusterProfiler)
library(enrichplot)
library(ggplot2)
library(data.table)
# SET THE DESIRED ORGANISM HERE
organism = "org.Mm.eg.db"
BiocManager::install(organism, character.only = TRUE, force = TRUE)
library(organism, character.only = TRUE)

# reading in data from deseq2
df = fread ("~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/Total/7_Full_Result_Total_tMCAo_Fold_Change.txt", header=TRUE)

# we want the log2 fold change 
original_gene_list <- df$Log2FC

# name the vector
names(original_gene_list) <- df$`Gene names`

# omit any NA values 
gene_list<-na.omit(original_gene_list)

# sort the list in decreasing order (required for clusterProfiler)
gene_list = sort(gene_list, decreasing = TRUE)

gse <- gseGO(geneList=gene_list, 
             ont ="ALL", 
             keyType = "SYMBOL", 
             nPerm = 10000, 
             minGSSize = 3, 
             maxGSSize = 800, 
             pvalueCutoff = 0.05, 
             verbose = TRUE, 
             OrgDb = organism, 
             pAdjustMethod = "none")

df_GEO <- as.data.frame(gse)
write.table (df_GEO, (file = paste0 ("~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/Total/Enrichment_Score/GEO_Enrichment_Total_tMCAo.txt")), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)


require(DOSE)
dotplot(gse, showCategory=10, split=".sign") + facet_grid(.~.sign)

#emapplot(gse, showCategory = 10)

# categorySize can be either 'pvalue' or 'geneNum'
#cnetplot(gse, categorySize="pvalue", foldChange=gene_list, showCategory = 3)

ridgeplot(gse) + labs(x = "enrichment distribution")

# Use the `Gene Set` param for the index in the title, and as the value for geneSetId
#gseaplot(gse, by = "all", title = gse$Description[2], geneSetID = 1)


##KEGG

ids<-bitr(names(original_gene_list), fromType = "SYMBOL", toType = "ENTREZID", OrgDb=organism)

# remove duplicate IDS (here I use "ENSEMBL", but it should be whatTotaler was selected as keyType)
dedup_ids = ids[!duplicated(ids[c("SYMBOL")]),]

# Create a new dataframe df2 which has only the genes which were successfully mapped using the bitr function above
df2 = df[df$`Gene names` %in% dedup_ids$SYMBOL,]

# Create a new column in df2 with the corresponding ENTREZ IDs
df2$Y = dedup_ids$ENTREZID

# Create a vector of the gene unuiverse
kegg_gene_list <- df2$Log2FC

# Name vector with ENTREZ ids
names(kegg_gene_list) <- df2$Y

# omit any NA values 
kegg_gene_list<-na.omit(kegg_gene_list)

# sort the list in decreasing order (required for clusterProfiler)
kegg_gene_list = sort(kegg_gene_list, decreasing = TRUE)

kegg_organism = "mmu"
kk2 <- gseKEGG(geneList     = kegg_gene_list,
               organism     = kegg_organism,
               nPerm        = 10000,
               minGSSize    = 3,
               maxGSSize    = 800,
               pvalueCutoff = 0.05,
               pAdjustMethod = "none",
               keyType       = "ncbi-geneid")

df_KEGG <- as.data.frame(kk2)
write.table (df_KEGG, (file = paste0 ("~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/Total/Enrichment_Score/KEGG_Enrichment_Total_tMCAo.txt")), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)

dotplot(kk2, showCategory = 10, title = "Enriched Pathways" , split=".sign") + facet_grid(.~.sign)

#emapplot(kk2)

# categorySize can be either 'pvalue' or 'geneNum'
#cnetplot(kk2, categorySize="pvalue", foldChange=gene_list)

ridgeplot(kk2) + labs(x = "enrichment distribution")

# Use the `Gene Set` param for the index in the title, and as the value for geneSetId
#gseaplot(kk2, by = "all", title = kk2$Description[1], geneSetID = 1)


library(pathview)

# Produce the native KEGG plot (PNG)
dme <- pathview(gene.data=kegg_gene_list, pathway.id="mmu04740", species = kegg_organism)

# Produce a different plot (PDF) (not displayed here)
dme <- pathview(gene.data=kegg_gene_list, pathway.id="mmu04740", species = kegg_organism, kegg.native = F)


knitr::include_graphics("mmu04740.pathview.png")

