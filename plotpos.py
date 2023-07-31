import matplotlib.pyplot as plt
import pandas as pd
from mpl_toolkits.axes_grid1 import make_axes_locatable

import matplotlib as mpl
import utm

import numpy as np
from matplotlib import cm, colors, ticker
from math import sqrt

## OPTIONS

# search = '20230424103830'
# search = '20230424104410'
# search = '20230424104814'
# search = '20221220120014'
# search = '20230208160939'
# search = '20221220115158'
# search = '20221220120735'
# search = '20221220120426'
# search = '20221220120014'
# search = '20221220115158'
# search = '20221220114801'
# search = '20230208160939'
# search = '20230119141333'
# search = '20230425103945'
# search = '20230425100903'
# search = '20230425101442'
# search = '20230425101821'
# search = '20230425102236'
# search = '20230425171652' # s_c post reset 1
# search = '20230425172115' # s_c post reset 2

# 04262023 AM manual drives
# search = '20230426104443' # ridges trash 1
# search = '20230426104711' # ridges trash 2
# search = '20230426105323' # ridges good 1 inner
# search = '20230426105657' # ridges good 2 inner
# search = '20230426110005' # ridges good 3 inner
# search = '20230426110335' # ridges good 4 outer
# search = '20230426110619' # ridges good 5 outer
# search = '20230426110857' # ridges good 6 outer
# search = '20230426111338' # blue 1
# search = '20230426114005' # blue 2
# search = '20230505150652'

# 04272023 Drives
# search = '20230427134945' # sports complex manual for testing
# search = '20230427141817' # 04272023_inner_auto_loop_1
# search = '20230427142512' # 04272023_inner_auto_loop_2
# search = '20230427143213' # 04272023_inner_auto_loop_3
# search = '20230427143535' # 04272023_outer_auto_loop_1
# search = '20230427144459' # 04272023_outer_auto_loop_2
# search = '20230427144917' # 04272023_outer_auto_loop_3

# inner simulation
# search = '20230508153305'

# outer simulation
# search = '20230508152939'

# autonomous_blue_route 05172023
# search = '20230517144113'
# search = '20230531095500'
# search = '20230531100859'

# PPP/RTK Tests
# search = '20230727154141' # init, ppp/rtk on
# search = '20230727155521' # we turned rtk off
# search = '20230727160519' # we turned rtk back on
# search = '20230727161146' # we turned ppp off
search = '20230727164735' # we cycled the novatel


## VAR INIT

font = {'family' : 'monospace',
        'weight' : 'normal',
        'size'   : 22}

mpl.rc('font', **font)

legend_array = []

ins_lat = []
ins_lon = []

ins_lat_NI = []
ins_lat_NF = []
ins_lat_PSRDIFF = []
ins_lat_SINGLE = []
ins_lat_INS_RTKFIXED = []
ins_lat_INS_RTKFLOAT = []
ins_lat_PPP_CONVERGING = []
ins_lat_PPP = []

ins_lon_NI = []
ins_lon_NF = []
ins_lon_PSRDIFF = []
ins_lon_SINGLE = []
ins_lon_INS_RTKFIXED = []
ins_lon_INS_RTKFLOAT = []
ins_lon_PPP_CONVERGING = []
ins_lon_PPP = []

ins_lat_std = []
ins_lon_std = []
ins_mag_std = []


## REST OF CODE WOO

df  = pd.read_csv(search+"gps.csv")
df2 = pd.read_csv(search+"data.csv")

t=df.measurement_time
sol_type = df.sol_type
latitude = df.latitude
longitude = df.longitude
altitude = df.height_msl
num_sats = df.num_sats_in_solution
lat_std = df.latitude_std_dev
lon_std = df.longitude_std_dev
alt_std = df.height_std_dev
ins_x_utm = df2.X
ins_y_utm = df2.Y
ins_z_utm = df2.Z

sol_type_array = sol_type.to_numpy()

# DEBUG
# print(sol_type)
# print(type(sol_type))
# print(sol_type_array)
# print(len(sol_type_array))
# unique_sol_types = sol_type.unique()
# print(unique_sol_types)

for p in range(len(ins_x_utm)):
    ins_latlon = utm.to_latlon(ins_x_utm[p], ins_y_utm[p], 17, 'S')
    ins_lat.append(ins_latlon[0])
    ins_lon.append(ins_latlon[1])

for s in range(len(lat_std)):
    ins_lat_std.append(lat_std[s])
    ins_lon_std.append(lon_std[s])
    ins_mag_std.append(sqrt(lat_std[s]**2 + lon_std[s]**2) )

# DEBUG
# print(ins_lat_std)
# print('===============================')
# print(ins_lon_std)
# print('===============================')
# print(ins_mag_std)
# print('===============================')

for q in range(len(sol_type_array)):

    # DEBUG
    # print(sol_type_array[q])
    # print(latitude[q])
    # print(latitude[q])

    if sol_type_array[q] == 50:
        ins_lat_NI.append(latitude[q])
        ins_lon_NI.append(longitude[q])
    elif sol_type_array[q] == 34:
        ins_lat_NF.append(latitude[q])
        ins_lon_NF.append(longitude[q])
    elif sol_type_array[q] == 17:
        ins_lat_PSRDIFF.append(latitude[q])
        ins_lon_PSRDIFF.append(longitude[q])
    elif sol_type_array[q] == 16:
        ins_lat_SINGLE.append(latitude[q])
        ins_lon_SINGLE.append(longitude[q])
    elif sol_type_array[q] == 68:
        ins_lat_PPP_CONVERGING.append(latitude[q])
        ins_lon_PPP_CONVERGING.append(longitude[q])
    elif sol_type_array[q] == 69:
        ins_lat_PPP.append(latitude[q])
        ins_lon_PPP.append(longitude[q])
    elif sol_type_array[q] == 56:
        ins_lat_INS_RTKFIXED.append(latitude[q])
        ins_lon_INS_RTKFIXED.append(longitude[q])
    elif sol_type_array[q] == 55:
        ins_lat_INS_RTKFLOAT.append(latitude[q])
        ins_lon_INS_RTKFLOAT.append(longitude[q])

# DEBUG
# print(len(ins_lat_NI), len(ins_lat_NF), len(ins_lat_PSRDIFF))
# print(ins_lat_NI, ins_lon_NI)

fig, ax1  = plt.subplots(2,1)
fig2, ax2 = plt.subplots(1,1)
fig3, ax3 = plt.subplots(2,1)
fig4, ax4 = plt.subplots(1,1)
fig5, ax5 = plt.subplots(1,1)
fig6, ax6 = plt.subplots(1,1)

ax1[0].scatter(longitude,latitude,c=sol_type, marker='o', alpha=0.3)
ax1[1].scatter(longitude,latitude,c=num_sats, marker='^', alpha=0.3)

ax1[0].grid(True)
ax1[1].grid(True)

sc1 = ax1[0].set_aspect('equal', 'box')
sc2 = ax1[1].set_aspect('equal', 'box')

if ins_lat_NI:
    ax3[0].scatter(ins_lon_NI,ins_lat_NI, c='g', marker='o', alpha=0.3)
    ax4.scatter(ins_lon_NI,ins_lat_NI, c='g', marker='o', alpha=0.3)
    legend_array.append('Narrow INT')
    print('Narrow Data Found!')
else:
    print('No Narrow Int Data! OH NO!')

if ins_lat_NF:
    ax3[0].scatter(ins_lon_NF,ins_lat_NF, c='y', marker='o', alpha=0.3)
    ax4.scatter(ins_lon_NF,ins_lat_NF, c='y', marker='o', alpha=0.3)
    legend_array.append('Narrow FLOAT')
    print('Float Data Found!')
else:
    print('No Narrow Float Data!')

if ins_lat_PSRDIFF:
    ax3[0].scatter(ins_lon_PSRDIFF,ins_lat_PSRDIFF, c='r', marker='o', alpha=0.3)
    ax4.scatter(ins_lon_PSRDIFF,ins_lat_PSRDIFF, c='r', marker='o', alpha=0.3)
    legend_array.append('PSRDIFF')
    print('PSRDIFF Data Found!')
else:
    print('No PSRDIFF Data!')

if ins_lat_SINGLE:
    ax3[0].scatter(ins_lon_SINGLE,ins_lat_SINGLE, c='m', marker='o', alpha=0.3)
    ax4.scatter(ins_lon_SINGLE,ins_lat_SINGLE, c='m', marker='o', alpha=0.3)
    legend_array.append('SINGLE')
    print('SINGLE Data Found!')
else:
    print('No SINGLE Data!')

if ins_lat_INS_RTKFIXED:
    ax3[0].scatter(ins_lon_INS_RTKFIXED,ins_lat_INS_RTKFIXED, c='r', marker='s', alpha=0.3)
    ax4.scatter(ins_lon_INS_RTKFIXED,ins_lat_INS_RTKFIXED, c='r', marker='s', alpha=0.3)
    legend_array.append('INS_RTKFIXED')
    print('INS_RTKFIXED Data Found!')
else:
    print('No INS_RTKFIXED Data!')

if ins_lat_INS_RTKFLOAT:
    ax3[0].scatter(ins_lon_INS_RTKFLOAT,ins_lat_INS_RTKFLOAT, c='g', marker='s', alpha=0.3)
    ax4.scatter(ins_lon_INS_RTKFLOAT,ins_lat_INS_RTKFLOAT, c='g', marker='s', alpha=0.3)
    legend_array.append('INS_RTKFLOAT')
    print('INS_RTKFLOAT Data Found!')
else:
    print('No INS_RTKFLOAT Data!')

if ins_lat_PPP_CONVERGING:
    ax3[0].scatter(ins_lon_PPP_CONVERGING,ins_lat_PPP_CONVERGING, c='r', marker='x', alpha=0.3)
    ax4.scatter(ins_lon_PPP_CONVERGING,ins_lat_PPP_CONVERGING, c='r', marker='x', alpha=0.3)
    legend_array.append('PPP_CONVERGING')
    print('PPP_CONVERGING Data Found!')
else:
    print('No PPP_CONVERGING')

if ins_lat_PPP:
    ax3[0].scatter(ins_lon_PPP,ins_lat_PPP, c='g', marker='x', alpha=0.3)
    ax4.scatter(ins_lon_PPP,ins_lat_PPP, c='g', marker='x', alpha=0.3)
    legend_array.append('PPP')
    print('PPP Data Found!')
else:
    print('No PPP Data!')


ax3[1].scatter(longitude,latitude,c=num_sats, marker='^', alpha=0.3)
ax5.scatter(longitude,latitude,c=num_sats, marker='^', alpha=0.3)
ax6.scatter(longitude,latitude,c=ins_mag_std, marker='^', alpha=0.3)


ax3[0].grid(True)
ax3[1].grid(True)
sc3 = ax3[0].set_aspect('equal', 'box')
sc3 = ax3[1].set_aspect('equal', 'box')

ax4.grid(True)
sc3 = ax4.set_aspect('equal', 'box')
sc5 = ax5.set_aspect('equal','box')
sc6 = ax6.set_aspect('equal','box')


# Fig 1 Plot 1 color bar
divider = make_axes_locatable(ax1[0])
cax = divider.append_axes("right", size="5%", pad=0.05)
norm = colors.Normalize(np.min(sol_type),np.max(sol_type))
cbar1 = fig.colorbar(sc1, ax=ax1[1], label='Solution Type', norm=norm, cax=cax)

# Fig 1 Plot 2 color bar
divider = make_axes_locatable(ax1[1])
cax = divider.append_axes("right", size="5%", pad=0.05)
norm2 = colors.Normalize(np.min(num_sats),np.max(num_sats))
cbar2=fig.colorbar(sc2, ax=ax1[1], label='SV Count', norm=norm2, cax=cax)

# Fig 3 Plot 2 color bar
divider = make_axes_locatable(ax3[1])
cax = divider.append_axes("right", size="5%", pad=0.05)
norm3 = colors.Normalize(np.min(num_sats),np.max(num_sats))
cbar3=fig.colorbar(sc3, ax=ax3[1], label='SV Count', norm=norm3, cax=cax)

# Fig 5 Plot 1 color bar
divider = make_axes_locatable(ax5)
cax = divider.append_axes("right", size="5%", pad=0.05)
norm5 = colors.Normalize(np.min(num_sats),np.max(num_sats))
cbar5=fig.colorbar(sc5, ax=ax5, label='SV Count', norm=norm5, cax=cax)

# Fig 6 Plot 1 color bar
divider = make_axes_locatable(ax6)
cax = divider.append_axes("right", size="5%", pad=0.05)
norm6 = colors.Normalize(np.min(ins_mag_std),np.max(ins_mag_std))
cbar6=fig.colorbar(sc6, ax=ax6, label='Std (m)', norm=norm6, cax=cax)
locator = ticker.LinearLocator(4)
cbar6.locator = locator
cbar6.update_ticks()

# Fig 3 Plot 1 legend
ax3[0].legend(legend_array)
ax4.legend(legend_array, loc='upper right')
# ax4.legend()

ax1[0].set_xlabel('Longitude')
ax1[0].set_ylabel('Latitude')

ax1[1].set_xlabel('Longitude')
ax1[1].set_ylabel('Latitude')

ax3[0].set_xlabel('Longitude')
ax3[0].set_ylabel('Latitude')

ax3[1].set_xlabel('Longitude')
ax3[1].set_ylabel('Latitude')

ax4.set_xlabel('Longitude')
ax4.set_ylabel('Latitude')

ax5.set_xlabel('Longitude')
ax5.set_ylabel('Latitude')

ax6.set_xlabel('Longitude')
ax6.set_ylabel('Latitude')

ax2.plot(ins_lon, ins_lat, c='m', label='100 Hz INS', alpha=0.5)
# ax2.scatter(map_lon, map_lat, c = 'black', label = "Routing Map", alpha = 0.5, s = 3)
ax2.scatter(longitude, latitude, marker='^',  label='1 Hz GNSS', alpha=0.5)
ax2.set_xlabel('Longitude')
ax2.set_ylabel('Latitude')
ax2.axis('equal')
ax2.grid(True)
ax2.legend()

plt.show()