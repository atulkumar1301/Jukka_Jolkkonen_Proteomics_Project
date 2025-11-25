library(data.table)
library(ggplot2)
library(dplyr)
library(ggpubr)

df_Case <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics data/EV/2_Col_Values_EV_tMCAo_Case.txt")

df_full_Case <- df_Case %>% count(Count)

df_full_Case$Type <- "Ipsilateral-bb"

df_Control <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics data/EV/2_Col_Values_EV_tMCAo_Control.txt")

df_full_Control <- df_Control %>% count(Count)

df_full_Control$Type <- "Contralateral-ba"

df_full <- rbind (df_full_Case, df_full_Control)

p_full <- ggplot (df_full, aes (fill = Type, y = n, x = Count)) +
  geom_bar (position = position_dodge(), stat = "identity")

p_full <- p_full + xlab ("Missing Count") + ylab ("Frequency") + labs (fill = "Type")

p_full <- p_full + scale_y_continuous(breaks = round (seq (0, 2000, by = 200), 1))

p_full <- p_full + scale_x_continuous(breaks = round (seq (0, 8, by = 1), 1))

p_full <- p_full + 
  theme (
    plot.title = element_text(family = "serif", size=16, face = "bold", hjust = 0.5),
    axis.title.x = element_text(family = "serif", size = 12),
    axis.title.y = element_text(family = "serif", size = 12),
    axis.text.x = element_text(family = "serif", size = 12),
    axis.text.y = element_text(family = "serif", size = 12),
    axis.line = element_line(),
    legend.title = element_text(family = "serif", size = 12),
    legend.text = element_text(family = "serif", size = 12),
    panel.background = element_blank()) + labs (title = "EV-tMCAo")
p_full
