"""I/O"""
from Database import Database
from Display import Display

class Input:
    """Input class"""

    def __init__(self):
        self.db = Database('localhost', 'root', '1234', 'vsp') # Arvid
        # self.db = Database('localhost', 'root', 'admin', 'vsp') # Alexander
        self.display = Display()
        print(
            "\n--- Command Template ---\n"
            "command. description <- type 'command' to execute description\n"
            "\n"
            "--- General Commands ---\n"
            "menu. - return to main menu\n"
            "search. - search for a channel or video\n"
            "search sorted. - sorts videos by views and channels by subscribers\n"
            "list channels. - lists 10 random channels\n"
            "list videos. - lists 10 random videos\n"
            "quit. - exit application"
        )

    def get_input(self):
        """General input function"""
        return input("-> ")

    def get_search_input(self, is_sorted):
        """Gets the search results of a string\n
           True -> Sorted\n
           False -> Unsorted
        """
        search_string = self.get_input()
        if is_sorted:
            return self.db.search_sorted(search_string)
        return self.db.search(search_string)

    def menu(self):
        """Prints all base commands"""
        self.extraCommands.clear()  # Clear extraCommands
        self.arguments.clear()      # Clear arguments
        self.display.menu()         # Display relevand text
                                    # Generate new extraCommands
        # func = self.get_command()    # Get new command
        # func(self)                      # Run function
        return True

    def search(self):
        """Get search results, prints it and creates extra commands"""
        self.extraCommands.clear()
        self.arguments.clear()
        self.display.search()
        results = self.get_search_input(False) # List of search results
        self.display.search_results(results)
        i = 1
        for result in results:
            if result['Type'] == 'Channel':
                self.extraCommands[str(i)] = self.show_channel
                channel = self.db.get_channel(result['ID'])
                self.arguments[str(i)] = channel
                i += 1
            elif result['Type'] == 'Video':
                self.extraCommands[str(i)] = self.show_video
                video = self.db.get_video(result['ID'])
                self.arguments[str(i)] = video
                i += 1
        return True

    def search_sorted(self):
        """Get search results (sorted), prints it and creates extra commands"""
        self.extraCommands.clear()
        self.arguments.clear()
        self.display.search_sorted()
        results = self.get_search_input(True) # List of search results
        self.display.search_results(results)
        i = 1
        for result in results:
            if result['Type'] == 'Channel':
                self.extraCommands[str(i)] = self.show_channel
                channel = self.db.get_channel(result['ID'])
                self.arguments[str(i)] = channel
                i += 1
            elif result['Type'] == 'Video':
                self.extraCommands[str(i)] = self.show_video
                video = self.db.get_video(result['ID'])
                self.arguments[str(i)] = video
                i += 1
        return True

    def list_channels(self):
        """Get random channels, prints them and creates extra commands"""
        self.extraCommands.clear()
        self.arguments.clear()
        channels = self.db.get_random_channels()
        self.display.random_channels(channels)
        i = 1
        for channel in channels:
            self.extraCommands[str(i)] = self.show_channel
            self.arguments[str(i)] = channel
            i += 1
        return True

    def list_videos(self):
        """Get random videos, prints them and creates extra commands"""
        self.extraCommands.clear()
        self.arguments.clear()
        videos = self.db.get_random_videos()
        self.display.random_videos(videos)
        i = 1
        for video in videos:
            self.extraCommands[str(i)] = self.show_video
            self.arguments[str(i)] = video
            i += 1
        return True

    def list_subscribers(self, channel_id):
        """Get subscribers, prints them and creates extra commands"""
        self.extraCommands.clear()
        self.arguments.clear()
        subscribers = self.db.get_subscribers(channel_id['channel_id'])
        self.display.list_subscribers(channel_id, subscribers)
        i = 1
        for channel in subscribers:
            self.extraCommands[str(i)] = self.show_channel
            self.arguments[str(i)] = channel
            i += 1
        return True

    def list_subscribed_to(self, channel_id):
        """Get subscribes to, prints them and creates extra commands"""
        self.extraCommands.clear()
        self.arguments.clear()
        subscriptions = self.db.get_subscribed_to(channel_id['channel_id'])
        self.display.list_subscribed_to(channel_id, subscriptions)
        i = 1
        for channel in subscriptions:
            self.extraCommands[str(i)] = self.show_channel
            self.arguments[str(i)] = channel
            i += 1
        return True

    def dummy(self, temp):
        """A dummy function to only return True"""
        return self == temp

    def show_channel(self, channel):
        """Displays channel and loads available commands"""
        self.extraCommands.clear()
        self.arguments.clear()
        videos = self.db.get_videos_by_channel(channel['channel_id'])
        self.extraCommands['list subscribers'] = self.list_subscribers
        self.arguments['list subscribers'] = channel['channel_id']
        self.extraCommands['list subscribes to'] = self.list_subscribed_to
        self.arguments['list subscribes to'] = channel['channel_id']
        i = 1
        for video in videos:
            self.extraCommands[str(i)] = self.show_video
            self.arguments[str(i)] = video
            i += 1

        self.display.channel(channel, videos)
        return True

    def show_video(self, video):
        """Displays video and loads available commands"""
        self.extraCommands.clear()
        self.arguments.clear()
        comments = self.db.list_comments(video['video_id'])
        self.extraCommands['channel'] = self.show_channel
        self.arguments['channel'] = self.db.get_channel(video['channel_id'])
        self.extraCommands['like'] = self.db.like_video
        self.arguments['like'] = video['video_id']

        self.display.video(video, comments)
        return True

    def get_command(self):
        """Get command input and validates the input. 
        Returns a function"""
        while True:
            command = self.get_input()

            if command in self.baseCommands:
                return self.baseCommands[command](self)

            if command in self.extraCommands:
                if command in self.arguments:
                    return self.extraCommands[command](self.arguments[command])
                return self.extraCommands[command](self)

            print(f"Error: {command} is not valid! Try again:")

    def run(self):
        """Main loop"""
        run = True
        while run:
            run = self.get_command()

    def quit(self):
        """Quit"""
        return False

    baseCommands = {
        "menu": menu,
        "search": search,
        "search sorted": search_sorted,
        "list channels": list_channels,
        "list videos": list_videos,
        "quit": quit
    }

    extraCommands = {

    }

    arguments = {

    }
