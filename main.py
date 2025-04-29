"""main"""
from Database import Database

db = Database('localhost', 'root', '1234', 'vsp')
channels = db.fetch_all('Videos') 
for channel in channels:
    print(channel['video_name'], channel['length'])