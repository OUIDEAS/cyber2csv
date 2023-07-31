import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import pearsonr, spearmanr, kendalltau
import warnings

## OPTIONS

corr_opt = True

## VAR INIT

# Specify the file name
# filename = '/home/autobuntu/Documents/PPP_RTK_Tests/07272023_novatel_logs/Exp1_Init_PPP_RTK.txt'
# filename = '/home/autobuntu/Documents/PPP_RTK_Tests/07272023_novatel_logs/Exp2_PPP_Only_RTK_Off.txt'
# filename = '/home/autobuntu/Documents/PPP_RTK_Tests/07272023_novatel_logs/Exp3_RTK_BACK_IN.txt'
# filename = '/home/autobuntu/Documents/PPP_RTK_Tests/07272023_novatel_logs/Exp4_PPP_OFF.txt'
# filename = '/home/autobuntu/Documents/PPP_RTK_Tests/07272023_novatel_logs/Exp5_PPP_Back_On_rtk_still_on.txt'
# filename = '/home/autobuntu/Documents/PPP_RTK_Tests/07272023_novatel_logs/Exp6_novatel_cycle.txt'
filename = '/home/autobuntu/Documents/red_route_test/red_route.txt'

extracted_data = []



## READING THE FILE

with open(filename, 'r') as file:
    file_content = file.readlines()

# Find the line containing 'SOL_COMPUTED'
data_line = None
for line in file_content:
    if 'SOL_COMPUTED' in line:
        data_line = line.strip()
        break

## EXTRACTING DATA FROM FILE

# Check if data_line is found, and then extract data
for line in file_content:
    if 'SOL_COMPUTED' in line:
        # Split the data line using whitespace as the delimiter
        data = line.strip().split()

        # Extract relevant data based on positions in the split list
        sol_stat = data[1]
        pos_type = data[2]
        lat = float(data[3])
        lon = float(data[4])
        alt = float(data[5])
        undulation = float(data[6])
        datum = data[7]
        lat_std = float(data[8])
        lon_std = float(data[9])
        alt_std = float(data[10])
        base_id = data[11]
        diff_age = float(data[12])
        soln_age = float(data[13])
        num_sats = int(data[14])
        num_sats_soln = int(data[15])
        num_l1e1b1 = int(data[16])
        num_mult_freq = int(data[17])
        reserved = data[18]
        soln_stat = data[19]
        galileo_bej_dou = data[20]
        gps_glonass = data[21]

        # Create a dictionary for the extracted data
        data_dict = {
            "SolStat": sol_stat,
            "PosType": pos_type,
            "Lat": lat,
            "Lon": lon,
            "Alt": alt,
            "Undulation": undulation,
            "Datum": datum,
            "LatStd": lat_std,
            "LonStd": lon_std,
            "AltStd": alt_std,
            "BaseID": base_id,
            "diff_age": diff_age,
            "soln_age": soln_age,
            "NumSats": num_sats,
            "NumSatsSoln": num_sats_soln,
            "NumL1E1B1": num_l1e1b1,
            "NumMultFreq": num_mult_freq,
            "Reserved": reserved,
            "SolnStat": soln_stat,
            "GalileoBejDou": galileo_bej_dou,
            "GPSGLONASS": gps_glonass
        }

        # Append the data dictionary to the list
        extracted_data.append(data_dict)



# Create the DataFrame with the extracted data
BESTPOSDataFrame = pd.DataFrame(extracted_data)

# DEBUG Display the DataFrame
# print(type(BESTPOSDataFrame))
# print(BESTPOSDataFrame)
# print('========================')
# Lat = BESTPOSDataFrame["LatStd"]
# print(Lat)

# Specify the columns you want to extract
columns_to_extract = ["Lat", "Lon", "Alt", "LatStd", "LonStd", "NumSats", "soln_age"]

# Extract the specified columns from the BESTPOSDataFrame
selected_data = BESTPOSDataFrame[columns_to_extract]
selected_array = selected_data.values

# Grabbing just the needed data then making sure it is formatted correctly
numeric_columns = ["Lat", "Lon", "Alt", "NumSats", "soln_age"]
selected_data[numeric_columns] = selected_data[numeric_columns].apply(pd.to_numeric, errors='coerce')


# DEBUG
# print(selected_array)
# print(type(selected_data))
# print(type(selected_data.Lat))
# print(type(selected_data.Lon))
# print(type(selected_data.Alt))
# print(type(selected_data.LatStd))
# print(type(selected_data.LonStd))
# print(type(selected_data.NumSats))
# print(type(selected_data.soln_age))
# print(selected_data[selected_data.isnull().any(axis=1)])
# Check for NaN/0 values in 'LatStd' and 'LonStd' columns
# nan_mask = selected_data[['LatStd', 'LonStd']].isna()
# rows_with_nan = selected_data[nan_mask.any(axis=1)]
# print("Rows with NaN values in 'LatStd' or 'LonStd':")
# print(rows_with_nan)
# zero_mask = (selected_data['LatStd'] == 0) | (selected_data['LonStd'] == 0)
# rows_with_zeros = selected_data[zero_mask]
# print("Rows with 'LatStd' or 'LonStd' equal to 0:")
# print(rows_with_zeros)

# Calculating the standard deviation
stdmag = np.sqrt(selected_data['LatStd']**2 + selected_data['LonStd']**2)

# DEBUG
# print(type(stdmag))
# print(stdmag)

## PUTTING DATA INTO THEIR OWN ARRAYS
latitudes = BESTPOSDataFrame["Lat"]
longitudes = BESTPOSDataFrame["Lon"]
num_sats = BESTPOSDataFrame["NumSats"]
soln_age = BESTPOSDataFrame["soln_age"]


## FIND CORRELATIONS

# -1 indicates a perfect negative correlation, 1 indicates a perfect positive correlation, and 0 indicates no correlation

if corr_opt:
    
    # Pearson
    print("PEARSON")
    correlation_std_mag_num_sats, p_value_std_mag_num_sats = pearsonr(stdmag, num_sats)
    correlation_std_mag_soln_age, p_value_std_mag_soln_age = pearsonr(stdmag, soln_age)
    correlation_num_sats_soln_age, p_value_num_sats_soln_age = pearsonr(num_sats, soln_age)
    print("Correlation between stdmag and num_sats:", correlation_std_mag_num_sats)
    print("Correlation between stdmag and soln_age:", correlation_std_mag_soln_age)
    print("Correlation between num_sats and soln_age:", correlation_num_sats_soln_age)

    # Spearman
    print("SPEARMAN")
    correlation_std_mag_num_sats, p_value_std_mag_num_sats = spearmanr(stdmag, num_sats)
    correlation_std_mag_soln_age, p_value_std_mag_soln_age = spearmanr(stdmag, soln_age)
    correlation_num_sats_soln_age, p_value_num_sats_soln_age = spearmanr(num_sats, soln_age)
    print("Spearman rank correlation between stdmag and num_sats:", correlation_std_mag_num_sats)
    print("Spearman rank correlation between stdmag and soln_age:", correlation_std_mag_soln_age)
    print("Spearman rank correlation between num_sats and soln_age:", correlation_num_sats_soln_age)

    # Kendalltau
    print("KENDALLTAU")
    correlation_std_mag_num_sats, p_value_std_mag_num_sats = kendalltau(stdmag, num_sats)
    correlation_std_mag_soln_age, p_value_std_mag_soln_age = kendalltau(stdmag, soln_age)
    correlation_num_sats_soln_age, p_value_num_sats_soln_age = kendalltau(num_sats, soln_age)
    print("Kendall rank correlation between stdmag and num_sats:", correlation_std_mag_num_sats)
    print("Kendall rank correlation between stdmag and soln_age:", correlation_std_mag_soln_age)
    print("Kendall rank correlation between num_sats and soln_age:", correlation_num_sats_soln_age)


## PLOTTING DATA

# Standard Deviation
plt.figure()
stdmagplot = plt.scatter(longitudes, latitudes, c=stdmag, cmap='viridis', s=50)
color_bar = plt.colorbar(stdmagplot)
color_bar.set_label('StdMag (m)')
plt.xlabel('Longitude')
plt.ylabel('Latitude')
plt.grid(True)
plt.axis('equal')
plt.tight_layout()

# Number of Satellites
plt.figure()
numsatplot = plt.scatter(longitudes, latitudes, c=num_sats, cmap='viridis', s=50)
color_bar = plt.colorbar(numsatplot)
color_bar.set_label('Num Sats')
plt.xlabel('Longitude')
plt.ylabel('Latitude')
plt.grid(True)
plt.axis('equal')
plt.tight_layout()

# Solution Age
plt.figure()
solnageplot = plt.scatter(longitudes, latitudes, c=soln_age, cmap='viridis', s=50)
color_bar = plt.colorbar(solnageplot)
color_bar.set_label('Soln Age (s)')
plt.xlabel('Longitude')
plt.ylabel('Latitude')
plt.grid(True)
plt.axis('equal')
plt.tight_layout()

# Show the plots
plt.show()






