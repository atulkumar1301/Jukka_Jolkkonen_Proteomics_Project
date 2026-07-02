library(data.table)
library(tidyverse)
library(ggplot2)

# 1. Read the raw text data directly
raw_data <- fread("~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/Common_tMCAo.txt")

# 2. Reshape to long format for ggplot2
heatmap_melted <- raw_data %>%
  pivot_longer(cols = c(Log2FC_EV, Log2FC_Total), 
               names_to = "Fraction", 
               values_to = "Log2FC") %>%
  mutate(
    Fraction = recode(Fraction, "Log2FC_EV" = "EV", "Log2FC_Total" = "Total Brain"),
    Direction = ifelse(Log2FC > 0, "Upregulated Set", "Downregulated Set")
  )

# Order genes cleanly by their EV Log2FC value
gene_order <- raw_data[order(Log2FC_EV), `Gene names`]
heatmap_melted$`Gene names` <- factor(heatmap_melted$`Gene names`, levels = gene_order)

# 3. Plot the Heatmap (Incompatibility Fixed)
fig5_heatmap <- ggplot(heatmap_melted, aes(x = Fraction, y = `Gene names`, fill = Log2FC)) +
  geom_tile(color = "grey93", linewidth = 0.4) +
  scale_fill_gradient2(
    low = "#313695",       # Deep elegant blue for down-regulation
    mid = "#F7F7F7",       # Off-white neutral midpoint
    high = "#B2182B",      # Rich crimson red for up-regulation
    midpoint = 0,
    name = expression(bold(Log[2]~Fold~Change))
  ) +
  # Using space = "free_y" guarantees the up/down boxes scale proportionally to gene count
  facet_grid(Direction ~ ., scales = "free_y", space = "free_y") +
  theme_minimal(base_family = "serif") +
  labs(
    title = "Expression Direction of Common Gene Set",
    x = "Sample Fraction", 
    y = "Gene Name"
  ) +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5, margin = margin(b = 15)),
    axis.title.x = element_text(size = 12, face = "bold", margin = margin(t = 10)),
    axis.title.y = element_text(size = 12, face = "bold", margin = margin(r = 10)),
    axis.text.y = element_text(size = 9, face = "italic", color = "black"),
    axis.text.x = element_text(size = 12, face = "bold", color = "black"),
    
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_rect(color = "grey85", fill = NA, linewidth = 0.5),
    
    strip.text = element_text(size = 10, face = "bold", color = "grey30"),
    strip.background = element_rect(fill = "grey95", color = "grey85"),
    
    legend.position = "right",
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 9),
    legend.key.height = unit(1.2, "cm"),
    legend.key.width = unit(0.4, "cm"),
    
    # Crucial adjustment: Add padding to the left/right margins of the plot canvas.
    # This artificially keeps the 2 columns narrow and elegant on an A4 page without using coord_fixed()!
    plot.margin = margin(t = 20, r = 80, b = 20, l = 80, unit = "pt")
  )

# Preview the plot on screen
print(fig5_heatmap)

# 4. Save explicitly as a standalone, standard portrait A4 sheet
ggsave(
  filename = "~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/Figure5_Heatmap_Common_Genes.pdf", 
  plot = fig5_heatmap, 
  width = 8.27,      # Exact standard A4 width (inches)
  height = 11.69,    # Exact standard A4 height (inches)
  units = "in",
  dpi = 300
)
