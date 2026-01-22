#Formatting file for volcano plot
import statistics
f_m = open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Full_Result_EV_tMCAo_Fold_Change.txt", 'w', 1)
f_m_1 = open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/7_Stat_EV_tMCAo_Fold_Change.txt", 'w', 1)
l_neg = []
l_pos = []
with open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/6_1_Result_FDR_Corrected_EV_tMCAo_Fold_Change_Imputed.txt", 'r') as expressionfile:
    line = expressionfile.readline ()
    f_m.write (line.rstrip () + "\t" + "Regulation" + "\n")
    for line in expressionfile:
        line_list = line.split ("\t")
        if (float (line_list [17]) < 0):
            l_neg.append (float(line_list [19]))
        elif (float (line_list [17]) > 0):
            l_pos.append (float(line_list [19]))
neg_median = float (statistics.median (l_neg))
pos_median = float (statistics.median (l_pos))
print ("Negative Median", neg_median)
print ("Postive Median", pos_median)
print ("Minimum Negative", min (l_neg))
print ("Maximum Postive", max (l_pos))
f_m_1.write ("Negative Median " + str( neg_median) + "\n")
f_m_1.write ("Postive Median " + str (pos_median) + "\n")
f_m_1.write ("Minimum Negative " + str (min (l_neg)) + "\n")
f_m_1.write ("Maximum Postive " + str (max (l_pos)) + "\n")
with open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/6_1_Result_FDR_Corrected_EV_tMCAo_Fold_Change_Imputed.txt", 'r') as expressionfile_1:
    line_1 = expressionfile_1.readline ()
    for line_1 in expressionfile_1:
        line_list_1 = line_1.split ("\t")
        if ((float (line_list_1 [17]) < 0) and (float (line_list_1 [18]) <= 0.05)):
           f_m.write (line_1.rstrip () + "\t" + "Significant Down-regulated" + "\n")
        elif ((float (line_list_1 [17]) < 0) and (float (line_list_1 [18]) >= 0.05)):
            f_m.write (line_1.rstrip () + "\t" + "Non-Significant Down-regulated" + "\n")
        elif ((float (line_list_1 [17]) > 0) and (float (line_list_1 [18]) <= 0.05)):
            f_m.write (line_1.rstrip () + "\t" + "Significant Up-regulated" + "\n")
        elif ((float (line_list_1 [17]) > 0) and (float (line_list_1 [18]) >= 0.05)):
            f_m.write (line_1.rstrip () + "\t" + "Non-Significant Up-regulated" + "\n")
        else:
            f_m.write (line_1)
