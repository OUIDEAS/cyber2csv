import pandas as pd
import json
import sys
import cyberreaderlib as cyberreader
from google.protobuf.json_format import MessageToJson
#import sensor_msgs.point_cloud2 as pc2
import zlib
import numpy as np
import base64
import glob 
import os 

###### OPTIONS ######

# Folder path

# PPP/RTK Test
# folder_path = '/home/autobuntu/Documents/PPP_RTK_Tests/07272023/exp1_both/' # init, ppp/rtk on
# folder_path = '/home/autobuntu/Documents/PPP_RTK_Tests/07272023/exp2_ppp_only_no_rtk/' # we turned rtk off
# folder_path = '/home/autobuntu/Documents/PPP_RTK_Tests/07272023/exp3_rtk_back_in/' # we turned rtk back on
# folder_path = '/home/autobuntu/Documents/PPP_RTK_Tests/07272023/exp4_ppp_off/' # we turned ppp off
# folder_path = '/home/autobuntu/Documents/PPP_RTK_Tests/07272023/exp5_ppp_back_on/' # we turned ppp back on
folder_path = '/home/autobuntu/Documents/PPP_RTK_Tests/07272023/exp6_novatel_cycle/' # we cycled the novatel


# Search string

# PPP/RTK Tests
# search = '20230727154141' # init, ppp/rtk on
# search = '20230727155521'  # we turned rtk off
# search = '20230727160519' # we turned rtk back on
# search = '20230727161146' # we turned ppp off
# search = '20230727162947' # we turned ppp back on
search = '20230727164735' # we cycled the novatel


###### VAR INIT ######

file_list = glob.glob(os.path.join(folder_path, search + '.*')) #+ glob.glob(os.path.join(folder_path, search))
file_list.sort()
xyzname = 'data.csv'
df = pd.DataFrame(columns=['t','X','Y','Z'])
gpsdf = pd.DataFrame()


###### DATA GRAB ######

for file_path in file_list:
    print(file_path)
    filename = file_path
    pbfactory = cyberreader.ProtobufFactory()
    reader = cyberreader.RecordReader(filename)
    for channel in reader.GetChannelList():
        desc = reader.GetProtoDesc(channel)
        pbfactory.RegisterMessage(desc)
        #print(channel)

        
    message = cyberreader.RecordMessage()
    num_msg = reader.header.message_number
    msgcount = 0
    while reader.ReadMessage(message):
        message_type = reader.GetMessageType(message.channel_name)
        msg = pbfactory.GenerateMessageByType(message_type)
        msg.ParseFromString(message.content)
        if(message.channel_name == '/apollo/localization/pose'):
            position = msg.pose.position
            newdf = pd.DataFrame([[msg.measurement_time, position.x, position.y, position.z]],columns=['t','X','Y','Z'])
            df = pd.concat([df, newdf])
            #jsdata = MessageToJson(msg)                          
            #df = pd.read_json(jsdata)
            
            # if(os.path.isfile(xyzname)):
            #     HeaderQ = False
            # else:
            #     HeaderQ = True
            # df.to_csv(xyzname, mode='a', index=False, header=HeaderQ)
            # HeaderQ=False
        elif(message.channel_name == '/apollo/sensor/gnss/best_pose'):
            data_dict = {}
            for field in msg.ListFields():
                data_dict[field[0].name] = [field[1]]
            newdf = pd.DataFrame.from_dict(data_dict)
            #for col in newdf.columns:
            #    print(col)
            #print(newdf)
            gpsdf = pd.concat([gpsdf, newdf])
            #df = pd.DataFrame([[msg.measurement_time, position.x, position.y, position.z]],columns=['t','X','Y','Z'])
            #jsdata = MessageToJson(msg)                          
            #df = pd.read_json(jsdata)
            #df.to_csv('gpsdata.csv', mode='a', index=False, header=HeaderQ)
            #HeaderQ=False
    #check the LiDAR data process
    # if(message.channel_name == '/apollo/sensor/velodyne32/PointCloud2'):
    #     msg = pbfactory.GenerateMessageByType(message_type)
    #     msg.ParseFromString(message.content)ß
    #     jsdata = json.loads(MessageToJson(msg))  
    #     #remove the text from this dictionary
    #     lidarlist = np.empty([len(jsdata['point']), 5])
    #     idx = 0
    #     for xyzpoint in jsdata['point']:
    #         newline = np.array((xyzpoint['x'],xyzpoint['y'],xyzpoint['z'],xyzpoint['intensity'],xyzpoint['timestamp']))
    #         lidarlist[idx,:] = newline
    #         idx = idx + 1
    #     lidarbytes = lidarlist.tobytes()
    #     compressed_data = zlib.compress(lidarbytes)
    #     print(f"Raw {len(lidarbytes)} Compressed: {len(compressed_data)}")
    #     b64data = base64.b64encode(compressed_data)
        
    #     jsdata['point'] = b64data
    #     # check output
    #     rawbytes = base64.b64decode(b64data)
    #     decompress = zlib.decompress(rawbytes)
    #     check = np.frombuffer(decompress)
    #     check = check.reshape((-1,5))
    #     print(np.array_equal(check, lidarlist))
    # 
    # 


###### DATA EXPORT ######
                
df.to_csv(search+xyzname,  index=False, header=True) #mode='a',
gpsdf.to_csv(search+'gps.csv')