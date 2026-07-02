library(data.table)
library(tidyverse)
library(ggplot2)

# 1. Load the significant datasets
ev_data <- fread("~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/EV_tMACo_Signi.txt")
total_data <- fread("~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/Total_tMACo_Signi.txt")

# Combine datasets and label the fraction origin
ev_subset <- ev_data[, .(`Gene names`, Log2FC, Fraction = "EV")]
total_subset <- total_data[, .(`Gene names`, Log2FC, Fraction = "Total Brain")]
combined_data <- rbind(ev_subset, total_subset)

# 2. Comprehensive brain cell type mapping
annotated_data <- combined_data %>%
  mutate(
    Cell_Type = case_when(
      `Gene names` %in% c("C1qc", "Usp11", "Hspa12b", "Ahi1", "Stip1", "Nedd4") ~ "Microglia /\nMacrophage",
      `Gene names` %in% c("Egfr", "Cyp46a1", "Camlg", "Ppib", "Gfap") ~ "Astrocyte",
      `Gene names` %in% c("Grm5", "Kctd16", "Dner", "Cadm2", "Prkcd", "Kalrn", "Scn1a") ~ "Neuron /\nSynaptic",
      `Gene names` %in% c("Pllp", "Reep2", "Mtmr9", "Slc7a14") ~ "Oligodendrocyte",
      `Gene names` %in% c("Ezr", "Tuba4a", "Adpgk", "Dock5", "Camsap3") ~ "Endothelial Cell",
      `Gene names` %in% c("Tubgcp3", "Acbd3", "Sec23b") ~ "Ependymal Cell",
      `Gene names` %in% c("Vti1b", "Tmed9", "Pdcd6") ~ "Pericyte /\nMural Cell",
      TRUE ~ "Other / Shared Machinery"
    )
  ) %>%
  filter(Cell_Type != "Other / Shared Machinery") %>%
  filter(!`Gene names` %in% c("", "NA") & !is.na(`Gene names`))

# Order gene names cleanly within the plotting workspace by their Log2FC values
annotated_data$`Gene names` <- reorder(annotated_data$`Gene names`, annotated_data$Log2FC)

# 3. Plotting the Expanded Cell Type Profile with Text Corrections
plot_all_cell_types <- ggplot(annotated_data, aes(x = Log2FC, y = `Gene names`, fill = Fraction)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.75), width = 0.7, color = "white", linewidth = 0.1) +
  facet_grid(Cell_Type ~ ., scales = "free_y", space = "free_y") +
  
  scale_fill_manual(values = c("EV" = "#FF4500", "Total Brain" = "#008B8B")) +
  geom_vline(xintercept = 0, linetype = "solid", color = "grey40", linewidth = 0.6) +
  
  theme_minimal(base_family = "serif") +
  labs(
    title = "Comprehensive Brain Cell-Type Proteomic Profiles",
    x = expression(bold(Log[2]~Fold~Change)),
    y = "Gene Name",
    fill = "Sample Fraction"
  ) +
  theme(
    plot.title = element_text(size = 13, face = "bold", hjust = 0.5, margin = margin(b = 15)),
    axis.title.x = element_text(size = 11, face = "bold", margin = margin(t = 10)),
    axis.title.y = element_text(size = 11, face = "bold", margin = margin(r = 10)),
    axis.text.y = element_text(size = 9, face = "italic", color = "black"),
    axis.text.x = element_text(size = 10, color = "black", face = "bold"),
    
    # FIX: Set the text alignment to center, and let long items wrap if needed
    strip.text.y = element_text(size = 9, face = "bold", color = "grey10", angle = 0, hjust = 0.5),
    strip.background = element_rect(fill = "grey96", color = "grey85", linewidth = 0.5),
    
    panel.grid.minor = element_blank(),
    panel.grid.major.y = element_blank(), 
    panel.grid.major.x = element_line(color = "grey92", linewidth = 0.4), 
    panel.border = element_rect(color = "grey85", fill = NA, linewidth = 0.5),
    
    legend.position = "top",
    legend.title = element_text(size = 10, face = "bold"),
    legend.text = element_text(size = 9),
    legend.margin = margin(b = 10),
    
    # FIX: Dramatically increase the right margin padding (r = 40) so labels don't clip off the A4 sheet
    plot.margin = margin(t = 15, r = 50, b = 15, l = 15, unit = "pt")
  )

# 4. Save directly as standard Portrait A4 sheet
ggsave("~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/Figure7_Comprehensive_Cell_Types.pdf", 
       plot = plot_all_cell_types, width = 8.27, height = 11.69, units = "in", dpi = 300)
