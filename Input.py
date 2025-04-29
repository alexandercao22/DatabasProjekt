"""I/O"""
# from Database import Database

class Input:
    # db = Database('localhost', 'root', '1234', 'vsp') # Arvid
    # db = Database('localhost', 'root', 'admin', 'vsp') # Alexander

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
            print(f"Menu lol\nGeneral commands\n")
            # print commands

        elif (userInput == "search"):
            print("Search for a channel or video:")
            searchString = self.GetInput()
            print(f"Searching for {searchString}\n")
            # cursor.callproc("search", searchString)
            # results = db.Search(searchString)
            # display.PrintSearch(results)
            
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
            # cursor.callproc("searchSorted", searchString)
            # results = db.SearchSorted(searchString)
            # display.PrintSearch(results)
            
            print("Enter a number to enter a channel or video:")
            num = self.GetInput()
            num = self.GetChannelOrVideo(num)

            if (num == 0):
                return True
            else:
                # Get channel or video and enter it
                print(f"Channel or video: {num}") # Remove this print after implemented

        elif (userInput == "list channels"):
            print(f"Some channels lol\n")
            # results = db.ListChannels()
            # display.PrintChannels(results)

            print("Enter a number to enter a channel:")
            num = self.GetInput()
            num = self.GetChannelOrVideo(num)

            # Get channel and enter it
            print(f"Channel: {num}") # Remove this print after implemented

        elif (userInput == "list videos"):
            print(f"Some videos lol\n")
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
