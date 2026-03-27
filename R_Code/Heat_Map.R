library(data.table)
library (reshape2)
library (ggplot2)

TABLE <- as.data.frame(matrix (ncol = 3, nrow = 56))
names(TABLE)<-c("Sample", "Cell_Type", "Log10P")
df <- fread ("~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/Cell_Type_Enrichment/EV_GI.txt")
cell_type <- unique (df$General_cell_type)
j <- 1
for (i in cell_type) {
  df_sub <- subset (df, df$General_cell_type == i)
  m = mean (df_sub$input_list_combined_log10p)
  TABLE [j, 1] <- "EV-GI"
  TABLE [j, 2] <- i
  TABLE [j, 3] <- m
  j <- j + 1
}
df <- fread ("~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/Cell_Type_Enrichment/EV_tMCAo.txt")
cell_type <- unique (df$General_cell_type)
for (i in cell_type) {
  df_sub <- subset (df, df$General_cell_type == i)
  m = mean (df_sub$input_list_combined_log10p)
  TABLE [j, 1] <- "EV-tMCAo"
  TABLE [j, 2] <- i
  TABLE [j, 3] <- m
  j <- j + 1
}
df <- fread ("~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/Total/Cell_Type_Enrichment/Total_GI.txt")
cell_type <- unique (df$General_cell_type)
for (i in cell_type) {
  df_sub <- subset (df, df$General_cell_type == i)
  m = mean (df_sub$input_list_combined_log10p)
  TABLE [j, 1] <- "Total-GI"
  TABLE [j, 2] <- i
  TABLE [j, 3] <- m
  j <- j + 1
}
df <- fread ("~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/Total/Cell_Type_Enrichment/Total_tMCAo.txt")
cell_type <- unique (df$General_cell_type)
for (i in cell_type) {
  df_sub <- subset (df, df$General_cell_type == i)
  m = mean (df_sub$input_list_combined_log10p)
  TABLE [j, 1] <- "Total-tMCAo"
  TABLE [j, 2] <- i
  TABLE [j, 3] <- m
  j <- j + 1
}

ggheatmap <- ggplot (data = TABLE, aes (x = Sample, y = Cell_Type, fill = Log10P)) + 
  geom_tile (color = "white") +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0.22, limit = c(0.01, 4.5), space = "Lab", name="Enrichment")+
  xlab("Sample") +
  ylab("Cell Type") +
  ggtitle ("Cell Type Enrichment")

ggheatmap <- ggheatmap +
  theme(
    plot.title = element_text(family = "serif", size=18, face = "bold"),
    axis.title.x = element_text(family = "serif", size=16),
    axis.title.y = element_text(family = "serif", size=16),
    axis.text.x = element_text(family = "serif", size=14),
    axis.text.y = element_text(family = "serif", size=14),
    legend.title = element_text(family = "serif", size=16),
    legend.text = element_text(family = "serif", size=16),
    panel.grid.major = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank(),
    axis.ticks = element_blank())

ggheatmap
