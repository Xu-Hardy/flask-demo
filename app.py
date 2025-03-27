from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello from multi-arch Flask Docker in production mode!"

if __name__ == '__main__':
    app.run()
