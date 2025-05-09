"""Database class"""
import mysql.connector
from mysql.connector import Error
 
class Database:
    """database"""
    def __init__(self) :
        self.connection = None
        self.cursor = None

    def __del__(self) :
        self.connection.close()
        self.cursor.close()
        
        
    def connect(self, host, user, password):
        try:
            self.connection = mysql.connector.connect(
                host = host,
                user = user,
                password = password,
            )
            if self.connection.is_connected():
                self.cursor = self.connection.cursor(dictionary=True)
                print("Connected")
                return True
        except Error as e:
            print("Error connecting to MySQL:", e)
            return False
    
    def setup(self):
        # Perform database setup operations
        setup = False

    def fetch_all(self, table):
        """Get whole table"""
        sql = f"SELECT * FROM {table}"
        self.cursor.execute(sql)
        return self.cursor.fetchall()

    def get_random_channels(self):
        """Get random channels"""
        ret = []
        self.cursor.callproc('listRandomChannels', [10])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret

    def get_random_videos(self):
        """Get random videos"""
        ret = []
        self.cursor.callproc('listRandomVideos', [10])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret

    def get_subscribers(self, channel_id):
        """Get subscribers of a channel"""
        ret = []
        self.cursor.callproc('listSubscribers', [channel_id])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret

    def get_subscribed_to(self, channel_id):
        """Get channels subscribed by a channel"""
        ret = []
        self.cursor.callproc('listSubscribedTo', [channel_id])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret

    def search(self, search_string):
        """Search in the database"""
        ret = []
        self.cursor.callproc('search', [search_string])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret

    def search_sorted(self, search_string):
        """Search in the database"""
        ret = []
        self.cursor.callproc('searchSorted', [search_string])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret
    
    def get_videos_by_channel(self, channel_id):
        """Search in the database"""
        ret = []
        self.cursor.callproc('listVideosByChannel', [channel_id])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret
    
    def list_comments(self, video_id):
        """Search in the database"""
        ret = []
        self.cursor.callproc('listComments', [video_id])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret
    
    def like_video(self, video_id):
        """Like video in database"""
        self.cursor.callproc('likeVideo', [video_id])
        return True

    def get_channel(self, channel_id):
        ret = []
        self.cursor.callproc('getChannel', [channel_id])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret[0]
    
    def get_video(self, video_id):
        ret = []
        self.cursor.callproc('getVideo', [video_id])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret[0]
