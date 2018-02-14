## Load required packages

    AntidoteRestServer = require './server'

## Parse the command line arguments and environment variables

    conf = require 'nconf'

    conf.argv().env().defaults
      antidote:
        hostname: 'localhost'
        port:     8087
      webserver:
        port:     3000

    antidoteHost = conf.get 'antidote:hostname'
    antidotePort = conf.get 'antidote:port'
    webserverPort = conf.get 'webserver:port'

    server = new AntidoteRestServer(antidoteHost, antidotePort, webserverPort)
    server.start()
    server.printConfiguration()
