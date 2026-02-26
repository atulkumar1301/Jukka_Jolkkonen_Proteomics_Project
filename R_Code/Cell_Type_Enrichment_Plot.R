library(data.table)
library(ggplot2)

df <- fread ("~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/Cell_Type_Enrichment/EV_GI.txt")
p <- ggplot (df, aes (x = General_cell_type, y = -log10(input_list_raw_p), color = General_cell_type)) +
  geom_boxplot() +
  geom_jitter (position=position_jitter(0.2))
p <- p + geom_hline (aes(yintercept=-log10(0.05), linetype = "p-value 0.05", col="black")) +
  geom_hline (aes (yintercept=-log10(0.01025641025), linetype = "FDR p-value 0.05", col="#D55E00")) +
  scale_linetype_manual(name = "p-value cut off", values = c(2, 2), 
                        guide = guide_legend(override.aes = list(color = c("black", "#D55E00"))))
p <- p + scale_y_continuous(breaks = round (seq (0, 10, by = 1), 1))
p <- p + xlab (expression ("Cell-Type")) + ylab (expression (-log[10]~(P)))
p <- p +
  theme(legend.position="none",
        plot.title = element_text(family = "serif", size=18, face = "bold", hjust = 0.5),
        axis.title.x = element_text(family = "serif", size=14),
        axis.title.y = element_text(family = "serif", size=14),
        axis.text.x = element_text(family = "serif", size=13, angle = 90),
        axis.text.y = element_text(family = "serif", size=13),
        legend.title = element_text(family = "serif", size=14),
        legend.text = element_text(family = "serif", size=14),
        panel.background = element_rect(fill = "white", linetype = "solid", color = "black")) + labs(title=expression("EV-GI Cell Type Enrichment"))
p
