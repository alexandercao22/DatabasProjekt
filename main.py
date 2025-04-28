"""main"""
import mysql.connector

print("C++ > Python")

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

db = Database('localhost', 'root', '1234', 'vsp')
