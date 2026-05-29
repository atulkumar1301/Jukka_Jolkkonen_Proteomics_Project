# ==========================================
# END-TO-END REPLICATION ANALYSIS
# ==========================================

# 1. INSTALL AND LOAD REQUIRED PACKAGES
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
if (!requireNamespace("org.Mm.eg.db", quietly = TRUE)) BiocManager::install("org.Mm.eg.db")
if (!requireNamespace("tidyverse", quietly = TRUE)) install.packages("tidyverse")

library(org.Mm.eg.db)
library(tidyverse)
library(ggplot2)

# ==========================================
# 2. LOAD AND CLEAN SEPARATE INPUT TXT FILES
# ==========================================
# CRITICAL: Replace 'ev_gi_data.txt' and 'ev_tmaco_data.txt' with your actual file names.
# CRITICAL: Replace 'Gene_Symbol' with the exact name of your gene column header.

# Read EV-GI dataset
gi_data <- read.delim("~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/5_Final_Data_EV_GI_Fold_Change.txt", header = TRUE, stringsAsFactors = FALSE)
ev_gi_genes_clean <- tolower(trimws(as.character(gi_data$Gene.names)))
ev_gi_genes_clean <- unique(ev_gi_genes_clean[ev_gi_genes_clean != ""])
total_gi_count <- length(ev_gi_genes_clean)

# Read EV-tMACo dataset
tmaco_data <- read.delim("~/OneDrive - University of Eastern Finland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/Signi_EV_tMACo.txt", header = TRUE, stringsAsFactors = FALSE)
ev_tmaco_genes_clean <- tolower(trimws(as.character(tmaco_data$Gene.names)))
ev_tmaco_genes_clean <- unique(ev_tmaco_genes_clean[ev_tmaco_genes_clean != ""])
total_tmaco_count <- length(ev_tmaco_genes_clean)

cat(sprintf("Loaded EV-GI: %d unique genes.\n", total_gi_count))
cat(sprintf("Loaded EV-tMACo: %d unique genes.\n\n", total_tmaco_count))


# ==========================================
# 3. DEFINE FIXED GO CODES (CONSOLIDATED FOR EVs)
# ==========================================
# We merge the generic "Cytoplasmic vesicle" and "Extracellular exosome" terms 
# into your primary bar to capture the true structural proteome of your EVs.

go_mapping <- list(
  "Exosomes"                   = c("GO:0070062", "GO:1903561", "GO:0031410"),
  "Lysosome"                   = "GO:0005764",
  "Endosome"                   = "GO:0005768",
  "Synaptic vesicle"           = "GO:0030672",
  "Endocytic vesicle membrane" = "GO:0030139"
)



# ==========================================
# 4. DOWNLOAD DATABASE GENE SETS (COMBINED OVERLAP)
# ==========================================
cat("Querying hierarchical mouse Gene Ontology mapping...\n")

go_reference_lists <- list()

for (label in names(go_mapping)) {
  go_ids <- go_mapping[[label]]
  
  # Pull genes across all sub-terms assigned to the category
  db_pull <- AnnotationDbi::select(org.Mm.eg.db, 
                                   keys = go_ids, 
                                   columns = "SYMBOL", 
                                   keytype = "GOALL")
  
  # Clean and store unique symbols
  go_reference_lists[[label]] <- tolower(unique(na.omit(db_pull$SYMBOL)))
}

# ==========================================
# 5. COMPUTE FRACTION PERCENTAGES (UPDATED ADJUSTMENT)
# ==========================================
# This calculates the intersection percentages against the list names cleanly
calculate_proportions <- function(my_dataset, total_count) {
  percentages <- sapply(names(go_mapping), function(label) {
    matches <- intersect(my_dataset, go_reference_lists[[label]])
    return((length(matches) / total_count) * 100)
  })
  return(percentages)
}

gi_percentages    <- calculate_proportions(ev_gi_genes_clean, total_gi_count)
tmaco_percentages <- calculate_proportions(ev_tmaco_genes_clean, total_tmaco_count)

# ==========================================
# 6. RESHAPE UNIFIED DATAFRAME (DYNAMIC FIX)
# ==========================================
n_categories <- length(go_mapping)

final_plot_data <- data.frame(
  Term = names(go_mapping),
  Dataset = rep("EV-tMACo", n_categories),
  Percentage = tmaco_percentages
)

# Keep the exact ordering matching your target reference image
final_plot_data$Term <- factor(final_plot_data$Term, levels = names(go_mapping))


# ==========================================
# 7. GENERATE REPLICA JOURNAL BAR CHART (serif)
# ==========================================
# Make sure your system's fonts are available to R
if (!requireNamespace("extrafont", quietly = TRUE)) install.packages("extrafont")
# Optional: Run extrafont::font_import() once if R cannot find your system fonts.

# ==========================================
# 7. GENERATE REPLICA JOURNAL BAR CHART (TIMES - TICK INTERVAL 5)
# ==========================================
p <- ggplot(final_plot_data, aes(x = Term, y = Percentage, fill = Dataset)) +
  # Render grouped bars matching layout proportions
  geom_bar(stat = "identity", position = position_dodge(width = 0.75), width = 0.65, color = "black", size = 0.4) +
  
  # Color profile matching target visual style
  scale_fill_manual(values = c("EV-GI" = "#165a72", "EV-tMACo" = "#de9c2a")) +
  
  # UPDATED: Set limits to 30 and breaks to seq(0, 30, by = 5) to change intervals to 5
  scale_y_continuous(expand = c(0, 0), limits = c(0, 30), breaks = seq(0, 30, by = 5)) + 
  
  theme_classic() +
  labs(
    x = NULL,
    y = "Percentage of proteins\nunder term"
  ) +
  theme(
    # Core Font Rule: Enforce serif globally across all elements
    text = element_text(family = "serif"),
    
    # Exact vertical rotation formatting for the long labels
    axis.text.x = element_text(family = "serif", angle = 90, vjust = 0.5, hjust = 1, color = "black", size = 11),
    axis.text.y = element_text(family = "serif", color = "black", size = 11),
    axis.title.y = element_text(family = "serif", color = "black", size = 12, face = "plain", margin = margin(r = 10)),
    
    # Sharp dark borders matching the reference image layout
    axis.line = element_line(color = "black", size = 0.8),
    axis.ticks = element_line(color = "black", size = 0.8),
    
    # Clean top label legend with Times font
    legend.position = "top",
    legend.title = element_blank(),
    legend.text = element_text(family = "serif", size = 10, face = "bold")
  )

# View final visual panel inside your R environment
print(p)


# Save vector image format file out to working directory
# Note: device = cairo_pdf ensures fonts render perfectly on your hard drive
ggsave("purity_validation_times.pdf", plot = p, width = 5, height = 6, dpi = 300, device = grDevices::cairo_pdf)

