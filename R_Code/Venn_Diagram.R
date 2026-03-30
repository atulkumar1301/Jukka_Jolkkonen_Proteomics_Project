library (ggVennDiagram)
library (data.table)
library (ggplot2)
library (tidyverse)
library (gridExtra)
library (patchwork)
library (grid)

### EV GI
df_EV_GI <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_GI_Fold_Change.txt")
#df_EV_GI_Sig_Pos <- df_EV_GI[df_EV_GI$p_Value <= 0.05 & df_EV_GI$Log2FC > 0]
#df_EV_GI_Sig_Neg <- df_EV_GI[df_EV_GI$p_Value <= 0.05 & df_EV_GI$Log2FC < 0]
df_EV_GI_Sig_Pos_FDR <- df_EV_GI[df_EV_GI$P_FDR <= 0.05 & df_EV_GI$Log2FC > 0]
df_EV_GI_Sig_Neg_FDR <- df_EV_GI[df_EV_GI$P_FDR <= 0.05 & df_EV_GI$Log2FC < 0]
EV_GI_Sig_Pos <- df_EV_GI_Sig_Pos_FDR$`Gene names`
EV_GI_Sig_Neg <- df_EV_GI_Sig_Neg_FDR$`Gene names`

### EV tMCAo
df_EV_tMCAo <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_tMCAo_Fold_Change.txt")
#df_EV_tMCAo_Sig_Pos <- df_EV_tMCAo[df_EV_tMCAo$p_Value <= 0.05 & df_EV_tMCAo$Log2FC > 0]
#df_EV_tMCAo_Sig_Neg <- df_EV_tMCAo[df_EV_tMCAo$p_Value <= 0.05 & df_EV_tMCAo$Log2FC < 0]
df_EV_tMCAo_Sig_Pos_FDR <- df_EV_tMCAo[df_EV_tMCAo$P_FDR <= 0.05 & df_EV_tMCAo$Log2FC > 0]
df_EV_tMCAo_Sig_Neg_FDR <- df_EV_tMCAo[df_EV_tMCAo$P_FDR <= 0.05 & df_EV_tMCAo$Log2FC < 0]
EV_tMCAo_Sig_Pos <- df_EV_tMCAo_Sig_Pos_FDR$`Gene names`
EV_tMCAo_Sig_Neg <- df_EV_tMCAo_Sig_Neg_FDR$`Gene names`

merged_df_EV_Pos <- merge (df_EV_GI_Sig_Pos_FDR, df_EV_tMCAo_Sig_Pos_FDR, by = "Gene names")

common_gene_df_EV_pos <- merged_df_EV_Pos [, "Gene names"]
colnames (common_gene_df_EV_pos) <- "Common Gene Set"

merged_df_EV_neg <- merge (df_EV_GI_Sig_Neg_FDR, df_EV_tMCAo_Sig_Neg_FDR, by = "Gene names")

common_gene_df_EV_neg <- merged_df_EV_neg [, "Gene names"]
colnames (common_gene_df_EV_neg) <- "Common Gene Set"

## Positive
venn_Pos <- list (EV_GI_Sig_Pos, EV_tMCAo_Sig_Pos)
p <- ggVennDiagram (venn_Pos, label_alpha = 0,category.names = c("GI","tMCAo"), show_elements = TRUE)
p <- p + ggplot2::scale_fill_gradient(low="cyan",high = "yellow") +
  ggtitle (expression ("Different Extent of upregulated proteomics between GI and tMCAo in EV"))
p <- p + theme(
  plot.title = element_text(family = "serif", size=18, face = "bold"),
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(),
  legend.title = element_text(family = "serif", size=16),
  legend.text = element_text(family = "serif", size=16),
  panel.grid.major = element_blank(),
  panel.border = element_blank(),
  panel.background = element_blank(),
  axis.ticks = element_blank())
p

my_theme <- ttheme_default(
  core = list(fg_params=list(fontsize = 14, fontfamily = "serif"), # Font size
              bg_params=list(fill=c("white", "lightgrey"))), # Alternating rows
  colhead = list(fg_params=list(col="navyblue", fontface="bold"))
)

p_table <- tableGrob(common_gene_df_EV_pos, theme = my_theme)

p + p_table

## Negative
venn_Neg <- list (EV_GI_Sig_Neg, EV_tMCAo_Sig_Neg)
p1 <- ggVennDiagram (venn_Neg, label_alpha = 0,category.names = c("GI","tMCAo"))
p1 <- p1 + ggplot2::scale_fill_gradient(low="white",high = "red") +
  ggtitle (expression ("Different Extent of down-regulated proteomics between GI and tMCAo in EV"))
p1 <- p1 + theme(
  plot.title = element_text(family = "serif", size=18, face = "bold"),
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(),
  legend.title = element_text(family = "serif", size=16),
  legend.text = element_text(family = "serif", size=16),
  panel.grid.major = element_blank(),
  panel.border = element_blank(),
  panel.background = element_blank(),
  axis.ticks = element_blank())

p1_table <- tableGrob(common_gene_df_EV_neg, theme = my_theme)

p1 + p1_table

####################

### Total GI
df_Total_GI <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/Total/7_Full_Result_Total_GI_Fold_Change.txt")
#df_Total_GI_Sig_Pos <- df_Total_GI[df_Total_GI$p_Value <= 0.05 & df_Total_GI$Log2FC > 0]
#df_Total_GI_Sig_Neg <- df_Total_GI[df_Total_GI$p_Value <= 0.05 & df_Total_GI$Log2FC < 0]
df_Total_GI_Sig_Pos_FDR <- df_Total_GI[df_Total_GI$P_FDR <= 0.05 & df_Total_GI$Log2FC > 0]
df_Total_GI_Sig_Neg_FDR <- df_Total_GI[df_Total_GI$P_FDR <= 0.05 & df_Total_GI$Log2FC < 0]
Total_GI_Sig_Pos <- df_Total_GI_Sig_Pos_FDR$`Gene names`
Total_GI_Sig_Neg <- df_Total_GI_Sig_Neg_FDR$`Gene names`

### Total tMCAo
df_Total_tMCAo <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/Total/7_Full_Result_Total_tMCAo_Fold_Change.txt")
#df_Total_tMCAo_Sig_Pos <- df_Total_tMCAo[df_Total_tMCAo$p_Value <= 0.05 & df_Total_tMCAo$Log2FC > 0]
#df_Total_tMCAo_Sig_Neg <- df_Total_tMCAo[df_Total_tMCAo$p_Value <= 0.05 & df_Total_tMCAo$Log2FC < 0]
df_Total_tMCAo_Sig_Pos_FDR <- df_Total_tMCAo[df_Total_tMCAo$P_FDR <= 0.05 & df_Total_tMCAo$Log2FC > 0]
df_Total_tMCAo_Sig_Neg_FDR <- df_Total_tMCAo[df_Total_tMCAo$P_FDR <= 0.05 & df_Total_tMCAo$Log2FC < 0]
Total_tMCAo_Sig_Pos <- df_Total_tMCAo_Sig_Pos_FDR$`Gene names`
Total_tMCAo_Sig_Neg <- df_Total_tMCAo_Sig_Neg_FDR$`Gene names`

merged_df_Total_Pos <- merge (df_Total_tMCAo_Sig_Pos_FDR, df_Total_GI_Sig_Pos_FDR, by = "Gene names")

common_gene_df_Total_pos <- merged_df_Total_Pos [, "Gene names"]
colnames (common_gene_df_Total_pos) <- "Common Gene Set"

merged_df_Total_neg <- merge (df_Total_tMCAo_Sig_Neg_FDR, df_Total_GI_Sig_Neg_FDR, by = "Gene names")

common_gene_df_Total_neg <- merged_df_Total_neg [, "Gene names"]
colnames (common_gene_df_Total_neg) <- "Common Gene Set"


## Positive
venn_Pos_Total <- list (Total_GI_Sig_Pos, Total_tMCAo_Sig_Pos)
p2 <- ggVennDiagram (venn_Pos_Total, label_alpha = 0,category.names = c("GI","tMCAo"))
p2 <- p2 + ggplot2::scale_fill_gradient(low="cyan",high = "yellow") +
  ggtitle (expression ("Different Extent of up-regulated proteomics between GI and tMCAo in Total"))
p2 <- p2 + theme(
  plot.title = element_text(family = "serif", size=18, face = "bold"),
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(),
  legend.title = element_text(family = "serif", size=16),
  legend.text = element_text(family = "serif", size=16),
  panel.grid.major = element_blank(),
  panel.border = element_blank(),
  panel.background = element_blank(),
  axis.ticks = element_blank())

p2_table <- tableGrob(common_gene_df_Total_pos, theme = my_theme)

p2 + p2_table


## Negative
venn_Neg_Total <- list (Total_GI_Sig_Neg, Total_tMCAo_Sig_Neg)
p3 <- ggVennDiagram (venn_Neg_Total, label_alpha = 0,category.names = c("GI","tMCAo"))
p3 <- p3 + ggplot2::scale_fill_gradient(low="white",high = "red") +
  ggtitle (expression ("Different Extent of down-regulated proteomics between GI and tMCAo in Total"))
p3 <- p3 + theme(
  plot.title = element_text(family = "serif", size=18, face = "bold"),
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(),
  legend.title = element_text(family = "serif", size=16),
  legend.text = element_text(family = "serif", size=16),
  panel.grid.major = element_blank(),
  panel.border = element_blank(),
  panel.background = element_blank(),
  axis.ticks = element_blank())

p3_table <- tableGrob(common_gene_df_Total_neg, theme = my_theme)

p3 + p3_table


##Full Pos GI
merged_df_GI_Pos <- merge (df_EV_GI_Sig_Pos_FDR, df_Total_GI_Sig_Pos_FDR, by = "Gene names")

common_gene_df_GI_pos <- merged_df_GI_Pos [, "Gene names"]
colnames (common_gene_df_GI_pos) <- "Common Gene Set"

venn_Pos_full_GI <- list (EV_GI_Sig_Pos, Total_GI_Sig_Pos)
p4 <- ggVennDiagram (venn_Pos_full_GI, label_alpha = 0,category.names = c("GI-EV","GI-Total"))
p4 <- p4 + ggplot2::scale_fill_gradient(low="cyan",high = "yellow") +
  ggtitle (expression ("Different Extent of up-regulated proteomics between GI Total and EV"))
p4 <- p4 + theme(
  plot.title = element_text(family = "serif", size=18, face = "bold"),
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(),
  legend.title = element_text(family = "serif", size=16),
  legend.text = element_text(family = "serif", size=16),
  panel.grid.major = element_blank(),
  panel.border = element_blank(),
  panel.background = element_blank(),
  axis.ticks = element_blank())

p4_table <- tableGrob(common_gene_df_GI_pos, theme = my_theme)

p4 + p4_table


##Full Pos tMCAO
merged_df_tMCAO_pos <- merge (df_EV_tMCAo_Sig_Pos_FDR, df_Total_tMCAo_Sig_Pos_FDR, by = "Gene names")

common_gene_df_tMCAO_pos <- merged_df_tMCAO_pos [, "Gene names"]
colnames (common_gene_df_tMCAO_pos) <- "Common Gene Set"

venn_Pos_full_tMCAO <- list (EV_tMCAo_Sig_Pos, Total_tMCAo_Sig_Pos)
p5 <- ggVennDiagram (venn_Pos_full_tMCAO, label_alpha = 0,category.names = c("tMCAo-EV", "tMCAo-Total"))
p5 <- p5 + ggplot2::scale_fill_gradient(low="cyan",high = "yellow") +
  ggtitle (expression ("Different Extent of up-regulated proteomics between tMCAo in Total and EV"))
p5 <- p5 + theme(
  plot.title = element_text(family = "serif", size=18, face = "bold"),
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(),
  legend.title = element_text(family = "serif", size=16),
  legend.text = element_text(family = "serif", size=16),
  panel.grid.major = element_blank(),
  panel.border = element_blank(),
  panel.background = element_blank(),
  axis.ticks = element_blank())

p5_table <- tableGrob(common_gene_df_tMCAO_pos, theme = my_theme)

p5 + p5_table

##Full Neg GI
merged_df_GI_neg <- merge (df_EV_GI_Sig_Neg_FDR, df_Total_GI_Sig_Neg_FDR, by = "Gene names")

common_gene_df_GI_neg <- merged_df_GI_neg [, "Gene names"]
colnames (common_gene_df_GI_neg) <- "Common Gene Set"

venn_Neg_full_GI <- list (EV_GI_Sig_Neg, Total_GI_Sig_Neg)
p6 <- ggVennDiagram (venn_Neg_full_GI, label_alpha = 0,category.names = c("GI-EV","GI-Total"))
p6 <- p6 + ggplot2::scale_fill_gradient(low="white",high = "red") +
  ggtitle (expression ("Different Extent of down-regulated proteomics between GI in Total and EV"))
p6 <- p6 + theme(
  plot.title = element_text(family = "serif", size=18, face = "bold"),
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(),
  legend.title = element_text(family = "serif", size=16),
  legend.text = element_text(family = "serif", size=16),
  panel.grid.major = element_blank(),
  panel.border = element_blank(),
  panel.background = element_blank(),
  axis.ticks = element_blank())

p6_table <- tableGrob(common_gene_df_GI_neg, theme = my_theme)

p6 + p6_table


##Full Neg tMCAO

merged_df_tMCAO_neg <- merge (df_EV_tMCAo_Sig_Neg_FDR, df_Total_tMCAo_Sig_Neg_FDR, by = "Gene names")

common_gene_df_tMCAO_neg <- merged_df_tMCAO_neg [, "Gene names"]
colnames (common_gene_df_tMCAO_neg) <- "Common Gene Set"

venn_Neg_full_tMCAO <- list (EV_tMCAo_Sig_Neg, Total_tMCAo_Sig_Neg)
p7 <- ggVennDiagram (venn_Neg_full_tMCAO, label_alpha = 0,category.names = c("tMCAo-EV", "tMCAo-Total"))
p7 <- p7 + ggplot2::scale_fill_gradient(low="white",high = "red") +
  ggtitle (expression ("Different Extent of down-regulated proteomics between tMCAo in Total and EV"))
p7 <- p7 + theme(
  plot.title = element_text(family = "serif", size=18, face = "bold"),
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(),
  legend.title = element_text(family = "serif", size=16),
  legend.text = element_text(family = "serif", size=16),
  panel.grid.major = element_blank(),
  panel.border = element_blank(),
  panel.background = element_blank(),
  axis.ticks = element_blank())

p7_table <- tableGrob(common_gene_df_tMCAO_neg, theme = my_theme)

p7 + p7_table


########
pos <- list (df_PD_AD_Sig_Pos, df_Denovo_PD_AD_Sig_Pos, df_Atypical_AD_Sig_Pos, df_PD_Sig_Pos, df_PD_Denovo_Sig_Pos, df_PSP_Sig_Pos)
pos_com <- reduce(pos, inner_join, by = 'CHEMICAL_NAME')
write.table (pos_com, file = paste0 ("Pos_Common_FDR.txt"), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)

neg <- list (df_PD_AD_Sig_Neg, df_Denovo_PD_AD_Sig_Neg, df_Atypical_AD_Sig_Neg, df_PD_Sig_Neg, df_PD_Denovo_Sig_Neg, df_PSP_Sig_Neg)
neg_com <- reduce(neg, inner_join, by = 'CHEMICAL_NAME')
write.table (neg_com, file = paste0 ("Neg_Common_FDR.txt"), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)
