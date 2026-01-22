
R version 4.5.2 (2025-10-31) -- "[Not] Part in a Rumble"
Copyright (C) 2025 The R Foundation for Statistical Computing
Platform: aarch64-apple-darwin20

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> #Volcano plot
> library(ggpubr)
Loading required package: ggplot2
> library(data.table)
data.table 1.17.2 using 4 threads (see ?getDTthreads).  Latest news: r-datatable.com
> library(ggplot2)
> library(ggrepel)
> library (plotly)

Attaching package: ‘plotly’

The following object is masked from ‘package:ggplot2’:

    last_plot

The following object is masked from ‘package:stats’:

    filter

The following object is masked from ‘package:graphics’:

    layout
> 
> 
> # The palette with grey:
> cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
> 
> # The palette with black:
> cbbPalette <- c("#000000", "#D55E00", "#56B4E9", "#009E73", "#E69F00", "#0072B2", "#F0E442", "#CC79A7")
> 
> ####Abeta
> 
> df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_GI_Fold_Change.txt")
> #Volcano plot
> library(ggpubr)
> library(data.table)
> library(ggplot2)
> library(ggrepel)
> library (plotly)
> 
> 
> # The palette with grey:
> cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
> 
> # The palette with black:
> cbbPalette <- c("#000000", "#D55E00", "#56B4E9", "#009E73", "#E69F00", "#0072B2", "#F0E442", "#CC79A7")
> 
> ####Abeta
> 
> df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_GI_Fold_Change.txt")
> p <- ggplot (data = df, aes (x = Log2FC, y = -log10(p_Value), col = Regulation, label = Label))+
+   geom_point ()+ geom_text_repel(max.overlaps = Inf, show.legend  = F)
> p <- p + geom_hline (aes(yintercept=-log10(0.05), linetype = "p-value 0.05", col="black")) +
+   geom_hline (aes (yintercept=-log10(0.00209197135), linetype = "FDR p-value 0.25", col="#D55E00")) +
+   scale_linetype_manual(name = "p-value cut off", values = c(2, 2), 
+                         guide = guide_legend(override.aes = list(color = c("black", "#D55E00")))) ##0.00518617021 (with No Dynamics)
> p <- p + scale_color_manual(values=cbbPalette, limits = force) + theme_light()
> p <- p + scale_x_continuous(breaks = round(seq(-5, 5, by = 1),1))
> p <- p + scale_y_continuous(breaks = round (seq (0, 80, by = 5), 1))
> p <- p + xlab (expression (log[2]~"Fold Change")) + labs (color = "Regulation") + ylab (expression (-log[10]~(P)))
> p <- p +
+   theme(legend.position="bottom",
+         plot.title = element_text(family = "serif", size=18, face = "bold", hjust = 0.5),
+         axis.title.x = element_text(family = "serif", size=16),
+         axis.title.y = element_text(family = "serif", size=16),
+         axis.text.x = element_text(family = "serif", size=12),
+         axis.text.y = element_text(family = "serif", size=12),
+         legend.title = element_text(family = "serif", size=16),
+         legend.text = element_text(family = "serif", size=16),
+         panel.background = element_blank()) + labs(title=expression("EV-GI"))
> p
> #Volcano plot
> library(ggpubr)
> library(data.table)
> library(ggplot2)
> library(ggrepel)
> library (plotly)
> 
> 
> # The palette with grey:
> cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
> 
> # The palette with black:
> cbbPalette <- c("#000000", "#D55E00", "#56B4E9", "#009E73", "#E69F00", "#0072B2", "#F0E442", "#CC79A7")
> 
> ####Abeta
> 
> df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_GI_Fold_Change.txt")
> p <- ggplot (data = df, aes (x = Log2FC, y = -log10(p_Value), col = Regulation, label = Label))+
+   geom_point ()+ geom_text_repel(max.overlaps = Inf, show.legend  = F)
> p <- p + geom_hline (aes(yintercept=-log10(0.05), linetype = "p-value 0.05", col="black")) +
+   geom_hline (aes (yintercept=-log10(0.00209197135), linetype = "FDR p-value 0.25", col="#D55E00")) +
+   scale_linetype_manual(name = "p-value cut off", values = c(2, 2), 
+                         guide = guide_legend(override.aes = list(color = c("black", "#D55E00")))) ##0.00518617021 (with No Dynamics)
> p <- p + scale_color_manual(values=cbbPalette, limits = force) + theme_light()
> p <- p + scale_x_continuous(breaks = round(seq(-5, 5, by = 1),1))
> p <- p + scale_y_continuous(breaks = round (seq (0, 9, by = 1), 1))
> p <- p + xlab (expression (log[2]~"Fold Change")) + labs (color = "Regulation") + ylab (expression (-log[10]~(P)))
> p <- p +
+   theme(legend.position="bottom",
+         plot.title = element_text(family = "serif", size=18, face = "bold", hjust = 0.5),
+         axis.title.x = element_text(family = "serif", size=16),
+         axis.title.y = element_text(family = "serif", size=16),
+         axis.text.x = element_text(family = "serif", size=12),
+         axis.text.y = element_text(family = "serif", size=12),
+         legend.title = element_text(family = "serif", size=16),
+         legend.text = element_text(family = "serif", size=16),
+         panel.background = element_blank()) + labs(title=expression("EV-GI"))
> p
> #Volcano plot
> library(ggpubr)
> library(data.table)
> library(ggplot2)
> library(ggrepel)
> library (plotly)
> 
> 
> # The palette with grey:
> cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
> 
> # The palette with black:
> cbbPalette <- c("#000000", "#D55E00", "#56B4E9", "#009E73", "#E69F00", "#0072B2", "#F0E442", "#CC79A7")
> 
> ####Abeta
> 
> df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_GI_Fold_Change.txt")
> p <- ggplot (data = df, aes (x = Log2FC, y = -log10(p_Value), col = Regulation, label = Label))+
+   geom_point ()+ geom_text_repel(max.overlaps = Inf, show.legend  = F)
> p <- p + geom_hline (aes(yintercept=-log10(0.05), linetype = "p-value 0.05", col="black")) +
+   geom_hline (aes (yintercept=-log10(0.00209197135), linetype = "FDR p-value 0.25", col="#D55E00")) +
+   scale_linetype_manual(name = "p-value cut off", values = c(2, 2), 
+                         guide = guide_legend(override.aes = list(color = c("black", "#D55E00")))) ##0.00518617021 (with No Dynamics)
> p <- p + scale_color_manual(values=cbbPalette, limits = force) + theme_light()
> p <- p + scale_x_continuous(breaks = round(seq(-5, 5, by = 1),1))
> p <- p + scale_y_continuous(breaks = round (seq (0, 15, by = 2), 1))
> p <- p + xlab (expression (log[2]~"Fold Change")) + labs (color = "Regulation") + ylab (expression (-log[10]~(P)))
> p <- p +
+   theme(legend.position="bottom",
+         plot.title = element_text(family = "serif", size=18, face = "bold", hjust = 0.5),
+         axis.title.x = element_text(family = "serif", size=16),
+         axis.title.y = element_text(family = "serif", size=16),
+         axis.text.x = element_text(family = "serif", size=12),
+         axis.text.y = element_text(family = "serif", size=12),
+         legend.title = element_text(family = "serif", size=16),
+         legend.text = element_text(family = "serif", size=16),
+         panel.background = element_blank()) + labs(title=expression("EV-GI"))
> p
> #Volcano plot
> library(ggpubr)
> library(data.table)
> library(ggplot2)
> library(ggrepel)
> library (plotly)
> 
> 
> # The palette with grey:
> cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
> 
> # The palette with black:
> cbbPalette <- c("#000000", "#D55E00", "#56B4E9", "#009E73", "#E69F00", "#0072B2", "#F0E442", "#CC79A7")
> 
> ####Abeta
> 
> df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_GI_Fold_Change.txt")
> p <- ggplot (data = df, aes (x = Log2FC, y = -log10(p_Value), col = Regulation, label = Label))+
+   geom_point ()+ geom_text_repel(max.overlaps = Inf, show.legend  = F)
> p <- p + geom_hline (aes(yintercept=-log10(0.05), linetype = "p-value 0.05", col="black")) +
+   geom_hline (aes (yintercept=-log10(0.00209197135), linetype = "FDR p-value 0.25", col="#D55E00")) +
+   scale_linetype_manual(name = "p-value cut off", values = c(2, 2), 
+                         guide = guide_legend(override.aes = list(color = c("black", "#D55E00")))) ##0.00518617021 (with No Dynamics)
> p <- p + scale_color_manual(values=cbbPalette, limits = force) + theme_light()
> p <- p + scale_x_continuous(breaks = round(seq(-5, 5, by = 1),1))
> p <- p + scale_y_continuous(breaks = round (seq (0, 15, by = 2), 1))
> p <- p + xlab (expression (log[2]~"Fold Change")) + labs (color = "Regulation") + ylab (expression (-log[10]~(P)))
> p <- p +
+   theme(legend.position="bottom",
+         plot.title = element_text(family = "serif", size=18, face = "bold", hjust = 0.5),
+         axis.title.x = element_text(family = "serif", size=16),
+         axis.title.y = element_text(family = "serif", size=16),
+         axis.text.x = element_text(family = "serif", size=12),
+         axis.text.y = element_text(family = "serif", size=12),
+         legend.title = element_text(family = "serif", size=16),
+         legend.text = element_text(family = "serif", size=16),
+         panel.background = element_blank()) + labs(title=expression("EV-GI"))
> p
> #Volcano plot
> library(ggpubr)
> library(data.table)
> library(ggplot2)
> library(ggrepel)
> library (plotly)
> 
> 
> # The palette with grey:
> cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
> 
> # The palette with black:
> cbbPalette <- c("#000000", "#D55E00", "#56B4E9", "#009E73", "#E69F00", "#0072B2", "#F0E442", "#CC79A7")
> 
> ####Abeta
> 
> df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_GI_Fold_Change.txt")
> p <- ggplot (data = df, aes (x = Log2FC, y = -log10(p_Value), col = Regulation, label = Label))+
+   geom_point ()+ geom_text_repel(max.overlaps = Inf, show.legend  = F)
> p <- p + geom_hline (aes(yintercept=-log10(0.05), linetype = "p-value 0.05", col="black")) +
+   geom_hline (aes (yintercept=-log10(0.00209197135), linetype = "FDR p-value 0.25", col="#D55E00")) +
+   scale_linetype_manual(name = "p-value cut off", values = c(2, 2), 
+                         guide = guide_legend(override.aes = list(color = c("black", "#D55E00")))) ##0.00518617021 (with No Dynamics)
> p <- p + scale_color_manual(values=cbbPalette, limits = force) + theme_light()
> p <- p + scale_x_continuous(breaks = round(seq(-5, 5, by = 1),1))
> p <- p + scale_y_continuous(breaks = round (seq (0, 15, by = 2), 1))
> p <- p + xlab (expression (log[2]~"Fold Change")) + labs (color = "Regulation") + ylab (expression (-log[10]~(P)))
> p <- p +
+   theme(legend.position="bottom",
+         plot.title = element_text(family = "serif", size=18, face = "bold", hjust = 0.5),
+         axis.title.x = element_text(family = "serif", size=16),
+         axis.title.y = element_text(family = "serif", size=16),
+         axis.text.x = element_text(family = "serif", size=12),
+         axis.text.y = element_text(family = "serif", size=12),
+         legend.title = element_text(family = "serif", size=16),
+         legend.text = element_text(family = "serif", size=16),
+         panel.background = element_blank()) + labs(title=expression("EV-GI"))
> p
> #Volcano plot
> library(ggpubr)
> library(data.table)
> library(ggplot2)
> library(ggrepel)
> library (plotly)
> 
> 
> # The palette with grey:
> cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
> 
> # The palette with black:
> cbbPalette <- c("#000000", "#D55E00", "#56B4E9", "#009E73", "#E69F00", "#0072B2", "#F0E442", "#CC79A7")
> 
> ####Abeta
> 
> df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_GI_Fold_Change.txt")
> p <- ggplot (data = df, aes (x = Log2FC, y = -log10(p_Value), col = Regulation, label = Label))+
+   geom_point ()+ geom_text_repel(max.overlaps = Inf, show.legend  = F)
> p <- p + geom_hline (aes(yintercept=-log10(0.05), linetype = "p-value 0.05", col="black")) +
+   geom_hline (aes (yintercept=-log10(0.00209197135), linetype = "FDR p-value 0.25", col="#D55E00")) +
+   scale_linetype_manual(name = "p-value cut off", values = c(2, 2), 
+                         guide = guide_legend(override.aes = list(color = c("black", "#D55E00")))) ##0.00518617021 (with No Dynamics)
> p <- p + scale_color_manual(values=cbbPalette, limits = force) + theme_light()
> p <- p + scale_x_continuous(breaks = round(seq(-5, 5, by = 1),1))
> p <- p + scale_y_continuous(breaks = round (seq (0, 15, by = 2), 1))
> p <- p + xlab (expression (log[2]~"Fold Change")) + labs (color = "Regulation") + ylab (expression (-log[10]~(P)))
> p <- p +
+   theme(legend.position="bottom",
+         plot.title = element_text(family = "serif", size=18, face = "bold", hjust = 0.5),
+         axis.title.x = element_text(family = "serif", size=16),
+         axis.title.y = element_text(family = "serif", size=16),
+         axis.text.x = element_text(family = "serif", size=12),
+         axis.text.y = element_text(family = "serif", size=12),
+         legend.title = element_text(family = "serif", size=16),
+         legend.text = element_text(family = "serif", size=16),
+         panel.background = element_blank()) + labs(title=expression("EV-GI"))
> p
> #Volcano plot
> library(ggpubr)
> library(data.table)
> library(ggplot2)
> library(ggrepel)
> library (plotly)
> 
> 
> # The palette with grey:
> cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
> 
> # The palette with black:
> cbbPalette <- c("#000000", "#F0E442", "#56B4E9", "#009E73", "#E69F00", "#0072B2", "#D55E00", "#CC79A7")
> 
> ####Abeta
> 
> df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_GI_Fold_Change.txt")
> p <- ggplot (data = df, aes (x = Log2FC, y = -log10(p_Value), col = Regulation, label = Label))+
+   geom_point ()+ geom_text_repel(max.overlaps = Inf, show.legend  = F)
> p <- p + geom_hline (aes(yintercept=-log10(0.05), linetype = "p-value 0.05", col="black")) +
+   geom_hline (aes (yintercept=-log10(0.00209197135), linetype = "FDR p-value 0.25", col="#D55E00")) +
+   scale_linetype_manual(name = "p-value cut off", values = c(2, 2), 
+                         guide = guide_legend(override.aes = list(color = c("black", "#D55E00")))) ##0.00518617021 (with No Dynamics)
> p <- p + scale_color_manual(values=cbbPalette, limits = force) + theme_light()
> p <- p + scale_x_continuous(breaks = round(seq(-5, 5, by = 1),1))
> p <- p + scale_y_continuous(breaks = round (seq (0, 15, by = 2), 1))
> p <- p + xlab (expression (log[2]~"Fold Change")) + labs (color = "Regulation") + ylab (expression (-log[10]~(P)))
> p <- p +
+   theme(legend.position="bottom",
+         plot.title = element_text(family = "serif", size=18, face = "bold", hjust = 0.5),
+         axis.title.x = element_text(family = "serif", size=16),
+         axis.title.y = element_text(family = "serif", size=16),
+         axis.text.x = element_text(family = "serif", size=12),
+         axis.text.y = element_text(family = "serif", size=12),
+         legend.title = element_text(family = "serif", size=16),
+         legend.text = element_text(family = "serif", size=16),
+         panel.background = element_blank()) + labs(title=expression("EV-GI"))
> p
> #Volcano plot
> library(ggpubr)
> library(data.table)
> library(ggplot2)
> library(ggrepel)
> library (plotly)
> 
> 
> # The palette with grey:
> cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
> 
> # The palette with black:
> cbbPalette <- c("#000000", "#CC79A7", "#56B4E9", "#009E73", "#E69F00", "#0072B2", "#D55E00", "#F0E442")
> 
> ####Abeta
> 
> df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_GI_Fold_Change.txt")
> p <- ggplot (data = df, aes (x = Log2FC, y = -log10(p_Value), col = Regulation, label = Label))+
+   geom_point ()+ geom_text_repel(max.overlaps = Inf, show.legend  = F)
> p <- p + geom_hline (aes(yintercept=-log10(0.05), linetype = "p-value 0.05", col="black")) +
+   geom_hline (aes (yintercept=-log10(0.00209197135), linetype = "FDR p-value 0.25", col="#D55E00")) +
+   scale_linetype_manual(name = "p-value cut off", values = c(2, 2), 
+                         guide = guide_legend(override.aes = list(color = c("black", "#D55E00")))) ##0.00518617021 (with No Dynamics)
> p <- p + scale_color_manual(values=cbbPalette, limits = force) + theme_light()
> p <- p + scale_x_continuous(breaks = round(seq(-5, 5, by = 1),1))
> p <- p + scale_y_continuous(breaks = round (seq (0, 15, by = 2), 1))
> p <- p + xlab (expression (log[2]~"Fold Change")) + labs (color = "Regulation") + ylab (expression (-log[10]~(P)))
> p <- p +
+   theme(legend.position="bottom",
+         plot.title = element_text(family = "serif", size=18, face = "bold", hjust = 0.5),
+         axis.title.x = element_text(family = "serif", size=16),
+         axis.title.y = element_text(family = "serif", size=16),
+         axis.text.x = element_text(family = "serif", size=12),
+         axis.text.y = element_text(family = "serif", size=12),
+         legend.title = element_text(family = "serif", size=16),
+         legend.text = element_text(family = "serif", size=16),
+         panel.background = element_blank()) + labs(title=expression("EV-GI"))
> p
> ####
> df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/6_Result_FDR_Corrected_EV_tMCAo_Fold_Change_Imputed.txt")
> df$P_Bonferroni <- p.adjust(df$p_Value, method = "bonferroni", n = length(df$p_Value))
> df$P_FDR <- p.adjust(df$p_Value, method = "fdr", n = length(df$p_Value))
> write.table(df, file = "~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/6_1_Result_FDR_Corrected_EV_tMCAo_Fold_Change_Imputed.txt", sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)
> ####
> df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/6_Result_FDR_Corrected_EV_tMCAo_Fold_Change_Imputed.txt")
> df$P_Bonferroni <- p.adjust(df$p_Value, method = "bonferroni", n = length(df$p_Value))
> df$P_FDR <- p.adjust(df$p_Value, method = "fdr", n = length(df$p_Value))
> write.table(df, file = "~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/6_1_Result_FDR_Corrected_EV_tMCAo_Fold_Change_Imputed.txt", sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)
> #Volcano plot
> library(ggpubr)
> library(data.table)
> library(ggplot2)
> library(ggrepel)
> library (plotly)
> 
> 
> # The palette with grey:
> cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
> 
> # The palette with black:
> cbbPalette <- c("#000000", "#D55E00", "#56B4E9", "#009E73", "#E69F00", "#0072B2", "#F0E442", "#CC79A7")
> 
> ####Abeta
> 
> df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_tMCAo_Fold_Change.txt")
> p <- ggplot (data = df, aes (x = Log2FC, y = -log10(p_Value), col = Regulation, label = Label))+
+   geom_point ()+ geom_text_repel(max.overlaps = Inf, show.legend  = F)
> p <- p + geom_hline (aes(yintercept=-log10(0.05), linetype = "p-value 0.05", col="black")) +
+   geom_hline (aes (yintercept=-log10(0.01678785286), linetype = "FDR p-value 0.05", col="#D55E00")) +
+   scale_linetype_manual(name = "p-value cut off", values = c(2, 2), 
+                         guide = guide_legend(override.aes = list(color = c("black", "#D55E00")))) ##0.00518617021 (with No Dynamics)
> p <- p + scale_color_manual(values=cbbPalette, limits = force) + theme_light()
> p <- p + scale_x_continuous(breaks = round(seq(-3, 4, by = 1),1))
> p <- p + scale_y_continuous(breaks = round (seq (0, 10, by = 1), 1))
> p <- p + xlab (expression (log[2]~"Fold Change")) + labs (color = "Regulation") + ylab (expression (-log[10]~(P)))
> p <- p +
+   theme(legend.position="bottom",
+         plot.title = element_text(family = "serif", size=18, face = "bold", hjust = 0.5),
+         axis.title.x = element_text(family = "serif", size=16),
+         axis.title.y = element_text(family = "serif", size=16),
+         axis.text.x = element_text(family = "serif", size=12),
+         axis.text.y = element_text(family = "serif", size=12),
+         legend.title = element_text(family = "serif", size=16),
+         legend.text = element_text(family = "serif", size=16),
+         panel.background = element_blank()) + labs(title=expression("EV-tMCAo"))
> p
> #Volcano plot
> library(ggpubr)
> library(data.table)
> library(ggplot2)
> library(ggrepel)
> library (plotly)
> 
> 
> # The palette with grey:
> cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
> 
> # The palette with black:
> cbbPalette <- c("#000000", "#CC79A7", "#56B4E9", "#009E73", "#E69F00", "#0072B2", "#D55E00", "#F0E442")
> 
> ####Abeta
> 
> df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_tMCAo_Fold_Change.txt")
> p <- ggplot (data = df, aes (x = Log2FC, y = -log10(p_Value), col = Regulation, label = Label))+
+   geom_point ()+ geom_text_repel(max.overlaps = Inf, show.legend  = F)
> p <- p + geom_hline (aes(yintercept=-log10(0.05), linetype = "p-value 0.05", col="black")) +
+   geom_hline (aes (yintercept=-log10(0.01678785286), linetype = "FDR p-value 0.05", col="#D55E00")) +
+   scale_linetype_manual(name = "p-value cut off", values = c(2, 2), 
+                         guide = guide_legend(override.aes = list(color = c("black", "#D55E00")))) ##0.00518617021 (with No Dynamics)
> p <- p + scale_color_manual(values=cbbPalette, limits = force) + theme_light()
> p <- p + scale_x_continuous(breaks = round(seq(-3, 4, by = 1),1))
> p <- p + scale_y_continuous(breaks = round (seq (0, 10, by = 1), 1))
> p <- p + xlab (expression (log[2]~"Fold Change")) + labs (color = "Regulation") + ylab (expression (-log[10]~(P)))
> p <- p +
+   theme(legend.position="bottom",
+         plot.title = element_text(family = "serif", size=18, face = "bold", hjust = 0.5),
+         axis.title.x = element_text(family = "serif", size=16),
+         axis.title.y = element_text(family = "serif", size=16),
+         axis.text.x = element_text(family = "serif", size=12),
+         axis.text.y = element_text(family = "serif", size=12),
+         legend.title = element_text(family = "serif", size=16),
+         legend.text = element_text(family = "serif", size=16),
+         panel.background = element_blank()) + labs(title=expression("EV-tMCAo"))
> p
> #Volcano plot
> library(ggpubr)
> library(data.table)
> library(ggplot2)
> library(ggrepel)
> library (plotly)
> 
> 
> # The palette with grey:
> cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
> 
> # The palette with black:
> cbbPalette <- c("#000000", "#CC79A7", "#56B4E9", "#009E73", "#E69F00", "#0072B2", "#D55E00", "#F0E442")
> 
> ####Abeta
> 
> df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_tMCAo_Fold_Change.txt")
> p <- ggplot (data = df, aes (x = Log2FC, y = -log10(p_Value), col = Regulation, label = Label))+
+   geom_point ()+ geom_text_repel(max.overlaps = Inf, show.legend  = F)
> p <- p + geom_hline (aes(yintercept=-log10(0.05), linetype = "p-value 0.05", col="black")) +
+   geom_hline (aes (yintercept=-log10(0.01678785286), linetype = "FDR p-value 0.05", col="#D55E00")) +
+   scale_linetype_manual(name = "p-value cut off", values = c(2, 2), 
+                         guide = guide_legend(override.aes = list(color = c("black", "#D55E00")))) ##0.00518617021 (with No Dynamics)
> p <- p + scale_color_manual(values=cbbPalette, limits = force) + theme_light()
> p <- p + scale_x_continuous(breaks = round(seq(-3, 4, by = 1),1))
> p <- p + scale_y_continuous(breaks = round (seq (0, 25, by = 3), 1))
> p <- p + xlab (expression (log[2]~"Fold Change")) + labs (color = "Regulation") + ylab (expression (-log[10]~(P)))
> p <- p +
+   theme(legend.position="bottom",
+         plot.title = element_text(family = "serif", size=18, face = "bold", hjust = 0.5),
+         axis.title.x = element_text(family = "serif", size=16),
+         axis.title.y = element_text(family = "serif", size=16),
+         axis.text.x = element_text(family = "serif", size=12),
+         axis.text.y = element_text(family = "serif", size=12),
+         legend.title = element_text(family = "serif", size=16),
+         legend.text = element_text(family = "serif", size=16),
+         panel.background = element_blank()) + labs(title=expression("EV-tMCAo"))
> p
> #Volcano plot
> library(ggpubr)
> library(data.table)
> library(ggplot2)
> library(ggrepel)
> library (plotly)
> 
> 
> # The palette with grey:
> cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
> 
> # The palette with black:
> cbbPalette <- c("#000000", "#CC79A7", "#56B4E9", "#009E73", "#E69F00", "#0072B2", "#D55E00", "#F0E442")
> 
> ####Abeta
> 
> df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_tMCAo_Fold_Change.txt")
> p <- ggplot (data = df, aes (x = Log2FC, y = -log10(p_Value), col = Regulation, label = Label))+
+   geom_point ()+ geom_text_repel(max.overlaps = Inf, show.legend  = F)
> p <- p + geom_hline (aes(yintercept=-log10(0.05), linetype = "p-value 0.05", col="black")) +
+   geom_hline (aes (yintercept=-log10(0.01678785286), linetype = "FDR p-value 0.05", col="#D55E00")) +
+   scale_linetype_manual(name = "p-value cut off", values = c(2, 2), 
+                         guide = guide_legend(override.aes = list(color = c("black", "#D55E00")))) ##0.00518617021 (with No Dynamics)
> p <- p + scale_color_manual(values=cbbPalette, limits = force) + theme_light()
> p <- p + scale_x_continuous(breaks = round(seq(-11, 11, by = 2),1))
> p <- p + scale_y_continuous(breaks = round (seq (0, 25, by = 3), 1))
> p <- p + xlab (expression (log[2]~"Fold Change")) + labs (color = "Regulation") + ylab (expression (-log[10]~(P)))
> p <- p +
+   theme(legend.position="bottom",
+         plot.title = element_text(family = "serif", size=18, face = "bold", hjust = 0.5),
+         axis.title.x = element_text(family = "serif", size=16),
+         axis.title.y = element_text(family = "serif", size=16),
+         axis.text.x = element_text(family = "serif", size=12),
+         axis.text.y = element_text(family = "serif", size=12),
+         legend.title = element_text(family = "serif", size=16),
+         legend.text = element_text(family = "serif", size=16),
+         panel.background = element_blank()) + labs(title=expression("EV-tMCAo"))
> p
> #Volcano plot
> library(ggpubr)
> library(data.table)
> library(ggplot2)
> library(ggrepel)
> library (plotly)
> 
> 
> # The palette with grey:
> cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
> 
> # The palette with black:
> cbbPalette <- c("#000000", "#CC79A7", "#56B4E9", "#009E73", "#E69F00", "#0072B2", "#D55E00", "#F0E442")
> 
> ####Abeta
> 
> df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_tMCAo_Fold_Change.txt")
> p <- ggplot (data = df, aes (x = Log2FC, y = -log10(p_Value), col = Regulation, label = Label))+
+   geom_point ()+ geom_text_repel(max.overlaps = Inf, show.legend  = F)
> p <- p + geom_hline (aes(yintercept=-log10(0.05), linetype = "p-value 0.05", col="black")) +
+   geom_hline (aes (yintercept=-log10(0.03787369207), linetype = "FDR p-value 0.05", col="#D55E00")) +
+   scale_linetype_manual(name = "p-value cut off", values = c(2, 2), 
+                         guide = guide_legend(override.aes = list(color = c("black", "#D55E00")))) ##0.00518617021 (with No Dynamics)
> p <- p + scale_color_manual(values=cbbPalette, limits = force) + theme_light()
> p <- p + scale_x_continuous(breaks = round(seq(-11, 11, by = 2),1))
> p <- p + scale_y_continuous(breaks = round (seq (0, 25, by = 3), 1))
> p <- p + xlab (expression (log[2]~"Fold Change")) + labs (color = "Regulation") + ylab (expression (-log[10]~(P)))
> p <- p +
+   theme(legend.position="bottom",
+         plot.title = element_text(family = "serif", size=18, face = "bold", hjust = 0.5),
+         axis.title.x = element_text(family = "serif", size=16),
+         axis.title.y = element_text(family = "serif", size=16),
+         axis.text.x = element_text(family = "serif", size=12),
+         axis.text.y = element_text(family = "serif", size=12),
+         legend.title = element_text(family = "serif", size=16),
+         legend.text = element_text(family = "serif", size=16),
+         panel.background = element_blank()) + labs(title=expression("EV-tMCAo"))
> p
> 
