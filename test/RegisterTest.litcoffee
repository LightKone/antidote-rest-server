    ## TODO: only testing using GET. check using other methods as well!

    chai = require 'chai'
    chaiHTTP = require 'chai-http'

    chai.should()
    chai.use(chaiHTTP)

    AntidoteRESTServer = require '../src/server'

    bucket = 'test'
    obj = 'register1'

    randomString = (length) ->
      Math.round(
        (Math.pow(36, length + 1) - Math.random() * Math.pow(36, length)))
        .toString(36).slice(1)

    describe 'Register', ->

      before ->
        @restServer = new AntidoteRESTServer('localhost', 8087, 3000)
        @restServer.start()
        @httpServer = @restServer.getHttpServer()

      after ->
        @restServer.stop()

      it 'Should be able to set it to any value', ->
        value = randomString(10)
        res = await chai.request(@httpServer)
          .get("/register/set/#{bucket}/#{obj}/#{value}")
        res.should.have.status 200
        res.text.should.be.a 'string'
        res.text.should.equal 'ok'
        res = await chai.request(@httpServer)
          .get("/register/read/#{bucket}/#{obj}")
        res.should.have.status 200
        res.text.should.be.a 'string'
        res.text.should.equal value
