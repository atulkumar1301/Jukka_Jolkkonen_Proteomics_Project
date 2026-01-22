import statistics
f_m = open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/6_Imputed_EV_tMCAo.txt", 'w', 1)
with open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Jukka_Jolkkonen/Jolkkonen_proteomics_data/EV/5_Final_Data_EV_tMCAo_Fold_Change.txt", 'r') as expressionfile:
    line = expressionfile.readline ()
    f_m.write (line)
    for line in expressionfile:
        if "NA" in line:
            line_list = line.split ("\t")
            f_m.write (str (line_list [0]) + "\t" + str (line_list [1]) + "\t" + str (line_list [2]) + "\t" + str (line_list [3]) + "\t")
            line_list_Ctrl = line_list [4:8]
            line_list_Case = line_list [9:15]
            if "NA" in line_list_Ctrl:
                numeric_values_ctrl = []
                for val in line_list_Ctrl:
                    try:
                        numeric_values_ctrl.append (float (val))
                    except:
                        print ("NA")
                median_value_ctrl = statistics.median(numeric_values_ctrl)
                for i, n in enumerate(line_list_Ctrl):
                    if n == "NA":
                        line_list_Ctrl[i] = median_value_ctrl
                f_m.write (str (line_list_Ctrl [0]) + "\t" + str (line_list_Ctrl [1]) + "\t" + str (line_list_Ctrl [2]) + "\t" + str (line_list_Ctrl [3]) + "\t" + "\t")
            else:
                f_m.write (str (line_list_Ctrl [0]) + "\t" + str (line_list_Ctrl [1]) + "\t" + str (line_list_Ctrl [2]) + "\t" + str (line_list_Ctrl [3]) + "\t" + "\t")
            if "NA" in line_list_Case:
                numeric_values_Case = []
                for val in line_list_Case:
                    try:
                        numeric_values_Case.append (float (val))
                    except:
                        print ("NA")
                median_value_Case = statistics.median(numeric_values_Case)
                for i, n in enumerate(line_list_Case):
                    if n == "NA":
                        line_list_Case[i] = median_value_Case
                f_m.write (str (line_list_Case [0]) + "\t" + str (line_list_Case [1]) + "\t" + str (line_list_Case [2]) + "\t" + str (line_list_Case [3]) + "\t" + str (line_list_Case [4]) + "\t" + str (line_list_Case [5]) + "\t" + "\n")
            else:
                f_m.write (str (line_list_Case [0]) + "\t" + str (line_list_Case [1]) + "\t" + str (line_list_Case [2]) + "\t" + str (line_list_Case [3]) + "\t" + str (line_list_Case [4]) + "\t" + str (line_list_Case [5]) + "\t" + "\n")
        else:
            f_m.write (line)
