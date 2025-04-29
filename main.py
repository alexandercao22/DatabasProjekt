"""main"""
from Input import Input
from Database import Database

if __name__ == "__main__":
    print("Welcome to VSP!\n\n" \
    "--- Instructions ---\n" \
    "command. descriptioon <- type \"command\" to execute description\n")

    app = Input()
    app.GetCommand("menu")

    run = True
    while (run):
        command = app.GetInput()
        run = app.GetCommand(command)
