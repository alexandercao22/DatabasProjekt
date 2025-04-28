"""main"""
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

db = Database('localhost', 'root', '1234', 'vsp')
channels = db.fetch_all('Channels')
for channel in channels:
    print(channel['channel_name'], channel['country'])