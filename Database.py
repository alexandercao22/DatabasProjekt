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
        sql = f"SELECT * FROM {table}"
        self.cursor.execute(sql)
        return self.cursor.fetchall()
    
    def getRandomChannels(self):
        ret = []
        self.cursor.callproc('listRandomChannels', [10])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret
    
    def getRandomVideos(self):
        ret = []
        self.cursor.callproc('listRandomVideos', [10])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret
    
    def getSubscribers(self, channel_id):
        ret = []
        self.cursor.callproc('listSubscribers', [channel_id])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret
    
    def getSubscribedTo(self, channel_id):
        ret = []
        self.cursor.callproc('listSubscribedTo', [channel_id])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret
    
    def Search(self, searchString):
        ret = []
        self.cursor.callproc('search', [searchString])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret
        
    
    def SearchSorted(self, searchString):
        ret = []
        self.cursor.callproc('searchSorted', [searchString])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret
