from flask import Flask
import socket

app = Flask(__name__)
hostname =  socket.gethostname() 

@app.route('/')
def index():
  return 'MyApp is running at ' + hostname

if __name__ == '__main__':
  app.run()
