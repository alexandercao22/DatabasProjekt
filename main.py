"""main"""
import mysql.connector
from Input import Input

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

if __name__ == "__main__":
    db = Database('localhost', 'root', 'admin', 'vsp')
    channels = db.fetch_all('Channels')
    for channel in channels:
        print(channel['channel_name'], channel['country'])
    print("\n")

    print("Welcome to VSP!\n\n" \
    "--- Instructions ---\n" \
    "command. descriptioon <- type \"command\" to execute description\n")

    app = Input()
    app.GetCommand("menu")

    run = True
    while (run):
        command = app.GetInput()
        run = app.GetCommand(command)
