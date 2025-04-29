"""I/O"""
from Database import Database
from Display import Display

class Input:
    # db = Database('localhost', 'root', '1234', 'vsp') # Arvid
    db = Database('localhost', 'root', 'admin', 'vsp') # Alexander
    display = Display()
    
    def GetInput(self):
        return input("-> ")
    
    def GetChannelOrVideo(self, num):
        run = True
        while (run):
            if (num == "return"):
                return 0

            try:
                num = int(num)
            except Exception:
                print(f"Error: {num} is not a valid command! Try again:")
                num = self.GetInput()
                continue
            run = False
        return num
    
    def GetCommand(self, userInput):
        if (userInput == "menu"):
            self.display.menu()
            # print commands

        elif (userInput == "search"):
            print("Search for a channel or video:")
            searchString = self.GetInput()
            print(f"Searching for {searchString}\n")

            results = self.db.Search(searchString)
            self.display.searchResults(results)
            
            print("Enter a number to enter a channel or video:")
            num = self.GetInput()
            num = self.GetChannelOrVideo(num)

            if (num == 0):
                return True
            else:
                # Get channel or video and enter it
                print(f"Channel or video: {num}") # Remove this print after implemented

        elif (userInput == "search sorted"):
            print("Search for a channel or video:")
            searchString = self.GetInput()
            print(f"Searching for {searchString}\n")

            results = self.db.SearchSorted(searchString)
            self.display.searchResults(results)
            
            print("Enter a number to enter a channel or video:")
            num = self.GetInput()
            num = self.GetChannelOrVideo(num)

            if (num == 0):
                return True
            else:
                # Get channel or video and enter it
                print(f"Channel or video: {num}") # Remove this print after implemented

        elif (userInput == "list channels"):
            print("Some channels lol\n")
            # results = db.ListChannels()
            # display.PrintChannels(results)

            print("Enter a number to enter a channel:")
            num = self.GetInput()
            num = self.GetChannelOrVideo(num)

            # Get channel and enter it
            print(f"Channel: {num}") # Remove this print after implemented

        elif (userInput == "list videos"):
            print("Some videos lol\n")
            # results = db.ListVideos()
            # display.PrintVideos(results)

            print("Enter a number to enter a video:")
            num = self.GetInput()
            num = self.GetChannelOrVideo(num)

            # Get video and enter it
            print(f"Video: {num}") # Remove this print after implemented

        elif (userInput == "quit"):
            return False
        else:
            print(f"Error: {userInput} is not a valid command!")
        return True
    
    def Menu(self):
        self.extraCommands.clear()  # Clear extraCommands
        self.arguments.clear()      # Clear arguments
        self.display.menu()         # Display relevand text
                                    # Generate new extraCommands
        func = self.getCommand()    # Get new command
        func()                      # Run function
        return True

    def Search(self):
        self.extraCommands.clear()
        self.arguments.clear()
        self.display.search()
        results = getSearchInput(False)  # Run getSearchInput which returns a list of search results
        self.display.searchResults(results)
        i = 1
        for result in results:
            if result['type'] == 'Channel':
                self.extraCommands[str(i)] = self.ShowChannel
                self.arguments[str(i)] = result
                i += 1
            elif result['type'] == 'Video':
                self.extraCommands[str(i)] = self.ShowVideo
                self.arguments[str(i)] = result
                i += 1
        return True
    
    def SearchSorted(self):
        self.extraCommands.clear()
        self.arguments.clear()
        self.display.searchSorted()
        results = getSearchInput(True)  # Run getSearchInput which returns a list of search results
        self.display.searchResults(results)
        i = 1
        for result in results:
            if result['type'] == 'Channel':
                self.extraCommands[str(i)] = self.ShowChannel
                self.arguments[str(i)] = result
                i += 1
            elif result['type'] == 'Video':
                self.extraCommands[str(i)] = self.ShowVideo
                self.arguments[str(i)] = result
                i += 1
        return True
    
    def ListChannels(self):
        self.extraCommands.clear()
        self.arguments.clear()
        channels = self.db.getRandomChannels()
        self.display.randomChannels(channels)
        i = 1
        for channel in channels:
            self.extraCommands[str(i)] = self.ShowChannel
            self.arguments[str(i)] = channel
            i += 1
        return True
    
    def ListVideos(self):
        self.extraCommands.clear()
        self.arguments.clear()
        videos = self.db.getRandomVideos()
        self.display.randomVideos(videos)
        i = 1
        for video in videos:
            self.extraCommands[str(i)] = self.ShowVideo
            self.arguments[str(i)] = video         
            i += 1
        return True
    
    def ListSubscribers(self, channel):
        self.extraCommands.clear()
        self.arguments.clear()
        subscribers = self.db.getSubscribers(channel['channel_id'])
        self.display.listSubscribers(channel, subscribers)
        i = 1
        for channel in subscribers:
            self.extraCommands[str(i)] = self.ShowChannel
            self.arguments[str(i)] = channel
            i += 1
        return True

    def ListSubscribedTo(self, channel):
        self.extraCommands.clear()
        self.arguments.clear()
        subscriptions = self.db.getSubscribedTo(channel['channel_id'])
        self.display.listSubscribedTo(channel, subscriptions)
        i = 1
        for channel in subscriptions:
            self.extraCommands[str(i)] = self.ShowChannel
            self.arguments[str(i)] = channel
            i += 1
        return True
    
    def ShowChannel(self, channel):
        self.extraCommands.clear()
        self.arguments.clear()

    
    
    baseCommands = {
        "menu": Menu,
        "seach": Search,
        "searchSorted": SearchSorted,
        "list channels": ListChannels,
        "list videos": ListVideos,
        # "quit": 0
    }

    extraCommands = {

    }

    arguments = {

    }

    
    