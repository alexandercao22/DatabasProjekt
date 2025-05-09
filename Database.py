"""Database class"""
import mysql.connector
from mysql.connector import Error

class Database:
    """database"""
    host = None
    user = None
    password = None
    database = "vsp"

    def __init__(self) :
        self.connection = None
        self.cursor = None

    # def __del__(self) :
    #     self.connection.close()
    #     self.cursor.close()

    def connect(self, host, user, password):
        """Connect"""
        try:
            self.connection = mysql.connector.connect(
                host = host,
                user = user,
                password = password,
            )
            if self.connection.is_connected():
                self.cursor = self.connection.cursor(dictionary=True)
                self.host = host
                self.user = user
                self.password = password
                print("Connected")
                return True
        except Error as e:
            print("Error connecting to MySQL:", e)
            return False

    def setup(self):
        """Setup"""
        self.cursor.execute("CREATE DATABASE IF NOT EXISTS vsp;")
        self.cursor.execute("USE vsp;")

        file = "vsp.sql"
        try:
            fd = open(file, "r", encoding="utf-8")
        except FileNotFoundError:
            print(f"Could not open {file}")
            return False

        sql_file = fd.read()
        fd.close()
        sql_commands = sql_file.split(';')

        for command in sql_commands:
            try:
                if command.strip() != "":
                    self.cursor.execute(command)
            except IOError as msg:
                print(f"Command skipped: {msg}")
                return False

        self.cursor.execute(
            "DELIMITER // " \
            "CREATE PROCEDURE listComments( " \
            "	IN video_id INT " \
            ") " \
            "BEGIN " \
            "	SELECT Comments.channel_id, Channels.channel_name, Comments.upload_date, comments.text, comments.likes FROM  " \
            "    Comments INNER JOIN Channels ON Comments.channel_id = Channels.channel_id " \
            "    WHERE video_id = Comments.video_id; " \
            "END // " \
            "CREATE PROCEDURE likeVideo( " \
            "	IN video_id INT " \
            ") " \
            "BEGIN " \
            "	UPDATE Videos " \
            "    SET Videos.likes = Videos.likes + 1 " \
            "    WHERE Videos.video_id = video_id; " \
            "END // " \
            "CREATE FUNCTION getSubCount( " \
            "	channel_id INT " \
            ") " \
            "RETURNS INT " \
            "DETERMINISTIC " \
            "BEGIN " \
            "	DECLARE result INT; " \
            "    " \
            "    SELECT COUNT(subscriber_id) INTO result FROM Subscribes " \
            "    WHERE channel_id = subscribed_to_id; " \
            "    RETURN result; " \
            "END // " \
            "CREATE PROCEDURE listSubscribers( " \
            "	IN channel_id INT " \
            ") " \
            "BEGIN " \
            "	SELECT *, getSubCount(Channels.channel_id) AS sub_count FROM  " \
            "    Channels INNER JOIN Subscribes ON Channels.channel_id = Subscribes.Subscribed_to_id " \
            "    WHERE channel_id = Channels.channel_id; " \
            "END // " \
            "CREATE PROCEDURE listSubscribedTo( " \
            "	IN channel_id INT " \
            ") " \
            "BEGIN " \
            "	SELECT *, getSubCount(Channels.channel_id) AS sub_count FROM  " \
            "    Channels INNER JOIN Subscribes ON Channels.channel_id = Subscribes.subscribed_to_id " \
            "    WHERE channel_id = Subscribes.subscriber_id; " \
            "END // " \
            "CREATE PROCEDURE getChannel( " \
            "	IN channel_id INT " \
            ") " \
            "BEGIN " \
            "	SELECT *, getSubCount(Channels.channel_id) AS sub_count FROM Channels  " \
            "    WHERE Channels.channel_id = channel_id; " \
            "END // " \
            "CREATE PROCEDURE getVideo( " \
            "	IN video_id INT " \
            ") " \
            "BEGIN " \
            "	SELECT * FROM Videos  " \
            "    WHERE Videos.video_id = video_id; " \
            "END // " \
            "CREATE PROCEDURE listRandomChannels( " \
            "	IN count INT " \
            ") " \
            "BEGIN " \
            "	SELECT *, getSubCount(channel_id) AS sub_count FROM Channels " \
            "    ORDER BY RAND() " \
            "    LIMIT count; " \
            "END // " \
            "CREATE PROCEDURE listRandomVideos( " \
            "	IN count INT " \
            ") " \
            "BEGIN " \
            "	SELECT * FROM Videos " \
            "    ORDER BY RAND() " \
            "    LIMIT count; " \
            "END // " \
            "CREATE PROCEDURE listVideosByChannel( " \
            "	IN channel_id INT " \
            ") " \
            "BEGIN " \
            "	SELECT * FROM Videos " \
            "    WHERE Videos.channel_id = channel_id " \
            "        ORDER BY Videos.upload_date; " \
            "END // " \
            "CREATE PROCEDURE search(IN searchString varchar(64))\n" \
            "NOT DETERMINISTIC " \
            "BEGIN " \
            "	SELECT channel_id AS ID, channel_name AS Name, getSubCount(channel_id) AS Metric, 'Channel' AS Type FROM Channels " \
            "		WHERE channel_name LIKE concat('%', searchString, '%') " \
            "	UNION " \
            "	SELECT video_id AS ID, video_name AS Name, views AS Metric, 'Video' AS Type FROM Videos " \
            "		WHERE video_name LIKE concat('%', searchString, '%') " \
            "        ORDER BY RAND(); " \
            "END// " \
            "CREATE PROCEDURE searchSorted(IN searchString varchar(64)) " \
            "NOT DETERMINISTIC " \
            "BEGIN " \
            "	SELECT channel_id AS ID, channel_name AS Name, getSubCount(channel_id) AS Metric, 'Channel' AS Type FROM Channels " \
            "		WHERE channel_name LIKE concat('%', searchString, '%') " \
            "	UNION " \
            "	SELECT video_id AS ID, video_name AS Name, views AS Metric, 'Video' AS Type FROM Videos " \
            "		WHERE video_name LIKE concat('%', searchString, '%') " \
            "        ORDER BY Type ASC, Metric DESC; " \
            "END// " \
            "DELIMITER ; "
        )

        self.connection = mysql.connector.connect(
            host = self.host,
            user = self.user,
            password = self.password,
            database = self.database
        )
        if self.connection.is_connected():
            self.cursor = self.connection.cursor(dictionary=True)
            print("Connected to vsp again")

        return True

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
        """Get channel"""
        ret = []
        self.cursor.callproc('getChannel', [channel_id])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret[0]

    def get_video(self, video_id):
        """Get video"""
        ret = []
        self.cursor.callproc('getVideo', [video_id])
        for result in self.cursor.stored_results():
            ret = result.fetchall()
            break
        return ret[0]
