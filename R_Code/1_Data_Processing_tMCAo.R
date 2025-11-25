library(data.table)
options(scipen = 999) ## To avoid scientific notation
df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics data/EV/1_Data_EV_tMCAo.txt")
df <- as.data.frame(df)

df_Case <- subset (df, df$Type == 1)
df_Control <- subset (df, df$Type == 0)

df_col_data_Case <- as.data.frame (colSums(df_Case==0))
df_col_data_Control <- as.data.frame (colSums(df_Control==0))

write.table (df_col_data_Case, "~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics data/EV/2_Col_Values_EV_tMCAo_Case.txt", sep = "\t", quote = FALSE, row.names = TRUE)
write.table (df_col_data_Control, "~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics data/EV/2_Col_Values_EV_tMCAo_Control.txt", sep = "\t", quote = FALSE, row.names = TRUE)

df_col_Case <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics data/EV/2_Col_Values_EV_tMCAo_Case.txt")
df_remove_prot_Case <- subset (df_col_Case, df_col_Case$Count==6)

df_col_Control <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics data/EV/2_Col_Values_EV_tMCAo_Control.txt")
df_remove_prot_Control <- subset (df_col_Control, df_col_Control$Count==6)

prot_to_remove <- unique (c(df_remove_prot_Case$Protein, df_remove_prot_Control$Protein))

df_final_data <- df [, !(names(df) %in% prot_to_remove)]

write.table (df_final_data, "~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics data/EV/3_Final_Data_EV_tMCAo.txt", sep = "\t", quote = FALSE, row.names = FALSE)

df_col_final_data <- as.data.frame (colSums(df_final_data==0))

write.table (df_col_final_data, "~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics data/EV/4_Col_Values_EV_tMCAo_Final_Data.txt", sep = "\t", quote = FALSE, row.names = TRUE)
