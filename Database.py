"""Database class"""
import mysql.connector

class Database:
    """database"""
    def __init__(self, host, user, password, database) :
        self.connection = mysql.connector.connect(
            host = host,
            user = user,
            password = password,
            database = database
        )
        self.cursor = self.connection.cursor(dictionary=True)

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
