"""main"""
from Input import Input
from Database import Database

if __name__ == "__main__":

    app = Input()
    app.GetCommand("menu")

    run = True
    while (run):
        command = app.GetInput()
        run = app.GetCommand(command)
