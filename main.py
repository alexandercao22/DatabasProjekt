"""main"""
from Input import Input

if __name__ == "__main__":

    app = Input()
    app.setup_database()

    app.run()
