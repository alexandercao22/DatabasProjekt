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
    
    def Search(self, searchString):
        self.cursor.callproc('search', [searchString])
        return self.cursor.stored_results()
    
    def SearchSorted(self, searchString):
        self.cursor.callproc('searchSorted', [searchString])
        return self.cursor.stored_results()
