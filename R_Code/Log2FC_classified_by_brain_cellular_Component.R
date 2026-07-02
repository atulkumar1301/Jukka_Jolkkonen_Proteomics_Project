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

# 2. Map targets to specific vesicle & organelle categories with custom line breaks (\n)
annotated_components <- combined_data %>%
  mutate(
    Cellular_Component = case_when(
      # Synaptic Vesicles
      `Gene names` %in% c("Grm5", "Kctd16", "Dner", "Scn1a", "Snapin", "Ina", "Kalrn") ~ "Synaptic Vesicle /\nSynapse",
      
      # Endocytic Vesicles
      `Gene names` %in% c("Ezr", "Tuba4a", "Cadm2", "Vti1b", "Camsap3", "Dock5", "Adpgk") ~ "Endocytic Vesicle /\nMembrane Ruffle",
      
      # Lysosomes
      `Gene names` %in% c("Inpp5j", "Psme3", "Psmc1", "Pdcd6", "Nedd4", "Stip1") ~ "Lysosome / Vacuolar /\nEndosome",
      
      # Mitochondria
      `Gene names` %in% c("Auh", "Gldc", "Mrpl10", "Mrpl15", "Lactb", "Timm22", "Gsr", "Cyp46a1") ~ "Mitochondria",
      
      # ER / Golgi Base Apparatus
      `Gene names` %in% c("Acbd3", "Bcap31", "Sec23b", "Tmed9", "Camlg", "Ppib") ~ "Endoplasmic Reticulum /\nGolgi",
      
      TRUE ~ "Other Cytosolic"
    )
  ) %>%
  filter(Cellular_Component != "Other Cytosolic") %>%
  filter(!`Gene names` %in% c("", "NA") & !is.na(`Gene names`))

# Order gene names cleanly within the plotting workspace by their Log2FC values for layout consistency
annotated_components$`Gene names` <- reorder(annotated_components$`Gene names`, annotated_components$Log2FC)

# 3. Create the Vibrant Cellular Component Plot with Text Alignment Corrections
plot_components <- ggplot(annotated_components, aes(x = Log2FC, y = `Gene names`, fill = Fraction)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.75), width = 0.7, color = "white", linewidth = 0.1) +
  facet_grid(Cellular_Component ~ ., scales = "free_y", space = "free_y") +
  
  # Vibrant color palette matching your cell type figure
  scale_fill_manual(values = c("EV" = "#FF4500", "Total Brain" = "#008B8B")) +
  geom_vline(xintercept = 0, linetype = "solid", color = "grey40", linewidth = 0.6) +
  
  theme_minimal(base_family = "serif") +
  labs(
    title = "Sub-Cellular Organelle Compartment Regulations",
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
    
    # FIX: Rotates names horizontally (angle=0) and aligns them neatly
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
    
    # FIX: Expands the right margin boundary box padding to prevent A4 boundary clipping
    plot.margin = margin(t = 15, r = 60, b = 15, l = 15, unit = "pt")
  )

# 4. Save directly as standard Portrait A4 sheet
ggsave("~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/Figure7_Cellular_Components_Vesicles.pdf", 
       plot = plot_components, width = 8.27, height = 11.69, units = "in", dpi = 300)
