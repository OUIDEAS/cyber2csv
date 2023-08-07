
# cyber2csv

Converts cyberbags containing ```'/apollo/localization/pose'``` or ```'/apollo/sensor/gnss/best_pose'``` into csv files. Respects enumeration automatically provided by apollo's cyber_recorder function.

```cyber2csv.py``` searches for all cyberbags in a folder with a search string and pulls data with respect to record number. Requires two variables to be set:

```
folder_path = '/fullpath/to/cyberbags'
search = '20230727164735'
```

Creates two .csv files to current directory. 

```plotpos.py``` Plots provides several plot options to visualize the topic data. Requires the search string of the generated csv:

```
search = '20230727164735'
```

```bestpos_log_reader.py``` searches the terminal output of the log BESTPOS ontime 1 of a PwrPak7 and plots data. Requires the full filepath & name of the file:

```
filename = '/home/autobuntu/Documents/PPP_RTK_Tests/07272023_novatel_logs/Exp6_novatel_cycle.txt'
```

In the MATLAB folder the ```BESTPOS_Log_Plotter.m``` script completes the same task as the ```bestpos_log_reader.py``` but with geo-plot.