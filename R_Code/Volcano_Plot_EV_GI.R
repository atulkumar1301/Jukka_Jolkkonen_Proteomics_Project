#Volcano plot
library(ggpubr)
library(data.table)
library(ggplot2)
library(ggrepel)
library (plotly)


# The palette with grey:
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# The palette with black:
cbbPalette <- c("#000000", "#CC79A7", "#56B4E9", "#009E73", "#E69F00", "#0072B2", "#D55E00", "#F0E442")


df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_GI_Fold_Change.txt")
p <- ggplot (data = df, aes (x = Log2FC, y = -log10(p_Value), col = Regulation, label = Label))+
  geom_point ()+ geom_text_repel(max.overlaps = Inf, show.legend  = F)
p <- p + geom_hline (aes(yintercept=-log10(0.05), linetype = "p-value 0.05", col="black")) +
  geom_hline (aes (yintercept=-log10(0.00209197135), linetype = "FDR p-value 0.05", col="#D55E00")) +
  scale_linetype_manual(name = "p-value cut off", values = c(2, 2), 
                        guide = guide_legend(override.aes = list(color = c("black", "#D55E00")))) ##0.00518617021 (with No Dynamics)
p <- p + scale_color_manual(values=cbbPalette, limits = force) + theme_light()
p <- p + scale_x_continuous(breaks = round(seq(-4, 5, by = 1),1))
p <- p + scale_y_continuous(breaks = round (seq (0, 15, by = 2), 1))
p <- p + xlab (expression (log[2]~"Fold Change")) + labs (color = "Regulation") + ylab (expression (-log[10]~(P)))
p <- p +
  theme(legend.position="bottom",
        plot.title = element_text(family = "serif", size=18, face = "bold", hjust = 0.5),
        axis.title.x = element_text(family = "serif", size=16),
        axis.title.y = element_text(family = "serif", size=16),
        axis.text.x = element_text(family = "serif", size=12),
        axis.text.y = element_text(family = "serif", size=12),
        legend.title = element_text(family = "serif", size=16),
        legend.text = element_text(family = "serif", size=16),
        panel.background = element_blank()) + labs(title=expression("EV-GI"))
p
