library(ggVennDiagram)
library(data.table)
library(ggplot2)
library(tidyverse)
### EV GI
df_EV_GI <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics data/EV/7_Full_Result_EV_GI_Fold_Change.txt")
df_EV_GI_Sig_Pos <- df_EV_GI[df_EV_GI$p_Value <= 0.05 & df_EV_GI$Log2FC > 0]
df_EV_GI_Sig_Neg <- df_EV_GI[df_EV_GI$p_Value <= 0.05 & df_EV_GI$Log2FC < 0]
df_EV_GI_Sig_Pos_FDR <- df_EV_GI[df_EV_GI$P_FDR <= 0.25 & df_EV_GI$Log2FC > 0]
df_EV_GI_Sig_Neg_FDR <- df_EV_GI[df_EV_GI$P_FDR <= 0.25 & df_EV_GI$Log2FC < 0]
EV_GI_Sig_Pos <- df_EV_GI_Sig_Pos$`Gene names`
EV_GI_Sig_Neg <- df_EV_GI_Sig_Neg$`Gene names`

### EV tMCAo
df_EV_tMCAo <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics data/EV/7_Full_Result_EV_tMCAo_Fold_Change.txt")
df_EV_tMCAo_Sig_Pos <- df_EV_tMCAo[df_EV_tMCAo$p_Value <= 0.05 & df_EV_tMCAo$Log2FC > 0]
df_EV_tMCAo_Sig_Neg <- df_EV_tMCAo[df_EV_tMCAo$p_Value <= 0.05 & df_EV_tMCAo$Log2FC < 0]
df_EV_tMCAo_Sig_Pos_FDR <- df_EV_tMCAo[df_EV_tMCAo$P_FDR <= 0.25 & df_EV_tMCAo$Log2FC > 0]
df_EV_tMCAo_Sig_Neg_FDR <- df_EV_tMCAo[df_EV_tMCAo$P_FDR <= 0.25 & df_EV_tMCAo$Log2FC < 0]
EV_tMCAo_Sig_Pos <- df_EV_tMCAo_Sig_Pos$`Gene names`
EV_tMCAo_Sig_Neg <- df_EV_tMCAo_Sig_Neg$`Gene names`


## Positive
venn_Pos <- list (EV_GI_Sig_Pos, EV_tMCAo_Sig_Pos)
p <- ggVennDiagram (venn_Pos, label_alpha = 0,category.names = c("GI","tMCAo"))
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
p1

####################

### Total GI
df_Total_GI <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics data/Total/7_Full_Result_Total_GI_Fold_Change.txt")
df_Total_GI_Sig_Pos <- df_Total_GI[df_Total_GI$p_Value <= 0.05 & df_Total_GI$Log2FC > 0]
df_Total_GI_Sig_Neg <- df_Total_GI[df_Total_GI$p_Value <= 0.05 & df_Total_GI$Log2FC < 0]
df_Total_GI_Sig_Pos_FDR <- df_Total_GI[df_Total_GI$P_FDR <= 0.05 & df_Total_GI$Log2FC > 0]
df_Total_GI_Sig_Neg_FDR <- df_Total_GI[df_Total_GI$P_FDR <= 0.05 & df_Total_GI$Log2FC < 0]
Total_GI_Sig_Pos <- df_Total_GI_Sig_Pos$`Gene names`
Total_GI_Sig_Neg <- df_Total_GI_Sig_Neg$`Gene names`

### Total tMCAo
df_Total_tMCAo <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics data/Total/7_Full_Result_Total_tMCAo_Fold_Change.txt")
df_Total_tMCAo_Sig_Pos <- df_Total_tMCAo[df_Total_tMCAo$p_Value <= 0.05 & df_Total_tMCAo$Log2FC > 0]
df_Total_tMCAo_Sig_Neg <- df_Total_tMCAo[df_Total_tMCAo$p_Value <= 0.05 & df_Total_tMCAo$Log2FC < 0]
df_Total_tMCAo_Sig_Pos_FDR <- df_Total_tMCAo[df_Total_tMCAo$P_FDR <= 0.25 & df_Total_tMCAo$Log2FC > 0]
df_Total_tMCAo_Sig_Neg_FDR <- df_Total_tMCAo[df_Total_tMCAo$P_FDR <= 0.25 & df_Total_tMCAo$Log2FC < 0]
Total_tMCAo_Sig_Pos <- df_Total_tMCAo_Sig_Pos$`Gene names`
Total_tMCAo_Sig_Neg <- df_Total_tMCAo_Sig_Neg$`Gene names`


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
p2

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
p3

##Full Pos

venn_Pos_full <- list (EV_GI_Sig_Pos, Total_GI_Sig_Pos, EV_tMCAo_Sig_Pos, Total_tMCAo_Sig_Pos)
p4 <- ggVennDiagram (venn_Pos_full, label_alpha = 0,category.names = c("GI-EV","GI-Total", "tMCAo-EV", "tMCAo-Total"))
p4 <- p4 + ggplot2::scale_fill_gradient(low="blue",high = "yellow") +
  ggtitle (expression ("Different Extent of up-regulated proteomics between GI and tMCAo in Total and EV"))
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
p4




########
pos <- list (df_PD_AD_Sig_Pos, df_Denovo_PD_AD_Sig_Pos, df_Atypical_AD_Sig_Pos, df_PD_Sig_Pos, df_PD_Denovo_Sig_Pos, df_PSP_Sig_Pos)
pos_com <- reduce(pos, inner_join, by = 'CHEMICAL_NAME')
write.table (pos_com, file = paste0 ("Pos_Common_FDR.txt"), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)

neg <- list (df_PD_AD_Sig_Neg, df_Denovo_PD_AD_Sig_Neg, df_Atypical_AD_Sig_Neg, df_PD_Sig_Neg, df_PD_Denovo_Sig_Neg, df_PSP_Sig_Neg)
neg_com <- reduce(neg, inner_join, by = 'CHEMICAL_NAME')
write.table (neg_com, file = paste0 ("Neg_Common_FDR.txt"), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)


