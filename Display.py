"""Display"""
import os

# Virtual class
class Display:
    """Class for displaying information to the user"""
    def __init__(self):
        print("Welcome to VSP!")

    def clearTerminal(self):
        """Clears the terminal of text"""
        os.system('cls' if os.name == 'nt' else 'clear')

    def menu(self):
        """Displays all available commands"""
        self.clearTerminal()
        print(
            "--- Command Template ---\n"
            "command. description <- type 'command' to execute description\n"
            "\n"
            "--- General Commands ---\n"
            "menu. - return to main menu\n"
            "list commands. - lists all general commands\n"
            "search. - search for a channel or video\n"
            "search sorted. - sorts videos by views and channels by subscribers\n"
            "list channels. - lists 10 random channels\n"
            "list videos. - lists 10 random videos\n"
            "quit. - exit application\n"
        )

    def search(self):
        """Displays text before search"""
        self.clearTerminal()
        print(
            "Search for a channel or video:\n"
        )

    def searchSorted(self):
        """Displays text before searchSorted"""
        self.clearTerminal()
        print(
            "Search for a channel or video (sorted):\n"
        )

    def randomChannels(self, channels):
        """Displays a list of channels"""
        self.clearTerminal()
        print("Here are some random channels:\n")
        i = 0
        for channel in channels:
            i += 1
            print(f"{i}. {channel['channel_name']}: {channel['sub_count']} subscribers")

    def randomVideos(self, videos):
        """Displays a list of videos"""
        self.clearTerminal()
        print("Here are some random videos:\n")
        i = 0
        for video in videos:
            i += 1
            print(f"{i}. {video['video_name']}: {video['views']} views")

    def searchResults(self, results):
        """Displays a list of results containing channels and/or videos"""
        self.clearTerminal()
        if len(results) == 0:
            print("Could not find any matching content")
        else:
            print("Search results:\n")
            i = 0
            for result in results:
                if result['Type'] == 'Channel':
                    print(f"{i}. {result['Name']}: {result['Metric']} subscribers")
                elif result['Type'] == 'Video':
                    print(f"{i}. {result['Name']}: {result['Metric']} views")
                i += 1

    def channel(self, channel, videos):
        """Displays all information of a channel and the videos uploaded by that channel"""
        self.clearTerminal()
        print("(Channel)")
        print("--- Info ---")
        print(
            f"Name: {channel['channel_name']}\n",
            f"Created: {channel['creation_date']}\n",
            f"Subscribers: {channel['sub_count']}\n",
            f"Country: {channel['country']}\n\n"
            )
        print("--- Actions ---")
        print("list subscribers. - lists all current channel subscribers\n",
              f"list subscribes to. - lists all channels subscribed to by {channel['channel_name']}\n\n"
            )
        print(f"--- Videos by {channel['channel_name']} ---")
        i = 0
        for video in videos:
            i += 1
            print(f"{i}. {video['video_name']}: {video['views']} views")
    
    def video(self, video, comments):
        """Displays all information of a video including its comments"""
        self.clearTerminal()
        print("(Video)")
        print("--- Info ---")
        print(
            f"Title: {video['video_name']}\n",
            f"Uploaded: {video['upload_date']}\n",
            f"Views: {video['views']}\n",
            f"Likes: {video['likes']}\n",
            f"Length: {video['length']}\n\n"
            )
        print("--- Actions ---")
        print("channel. - go to video creator\n",
              "like. - like the video\n\n"
            )
        print("--- Comments ---")
        for comment in comments:
            print(
                f"@{comment['channel_name']}: {comment['upload_date']}\n",
                f"{comment['text']}\n",
                f"Likes: {comment['likes']}\n"
                )
        
    def listSubscribers(self, subscribedTo, channels):
        """Displays all channels that are subscribed to 'subscribedTo'"""
        print(f"Here are the channels subscribed to {subscribedTo['channel_name']}:")
        i = 0
        for channel in channels:
            i += 1
            print(f"{i}. {channel['channel_name']}: {channel['sub_count']} subscribers")

    def listSubscriptions(self, subscriber, channels):
        """Displays all chanels subscribed to by 'subscriber'"""
        print(f"Here are the channels that {subscriber['channel_name']} is subscribed to:")
        i = 0
        for channel in channels:
            i += 1
            print(f"{i}. {channel['channel_name']}: {channel['sub_count']} subscribers")

    def quit(self):
        """Displays a message before the application closes"""
        self.clearTerminal()
        print("Exiting application...\n")
