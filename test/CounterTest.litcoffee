    ## TODO: only testing using GET. check using other methods as well!

    chai = require 'chai'
    chaiHTTP = require 'chai-http'

    chai.should()
    chai.use(chaiHTTP)

    AntidoteRESTServer = require '../src/server'

    bucket = 'test'
    obj = 'counter1'

    describe 'Counter', ->

      before ->
        @restServer = new AntidoteRESTServer('localhost', 8087, 3000)
        @restServer.start()
        @httpServer = @restServer.getHttpServer()

      after ->
        @restServer.stop()

      beforeEach ->
        res = await chai.request(@httpServer)
          .get("/counter/read/#{bucket}/#{obj}")
        value = - parseInt res.text
        res = await chai.request(@httpServer)
          .get("/counter/increment/#{bucket}/#{obj}/#{value}")

      it 'Should increment by one by default', ->
        res = await chai.request(@httpServer)
          .get("/counter/increment/#{bucket}/#{obj}")
        res.should.have.status 200
        res.text.should.be.a 'string'
        res.text.should.equal 'ok'
        res = await chai.request(@httpServer)
          .get("/counter/read/#{bucket}/#{obj}")
        res.should.have.status 200
        res.text.should.be.a 'string'
        parseInt(res.text).should.equal 1

      it 'Should increment by amount specified', ->
        value = Math.floor(Math.random() * 20) + 10 # [10;29]
        res = await chai.request(@httpServer)
          .get("/counter/increment/#{bucket}/#{obj}/#{value}")
        res.should.have.status 200
        res.text.should.be.a 'string'
        res.text.should.equal 'ok'
        res = await chai.request(@httpServer)
          .get("/counter/read/#{bucket}/#{obj}")
        res.should.have.status 200
        res.text.should.be.a 'string'
        parseInt(res.text).should.equal value

      it 'Should decrement if specified amount is negative', ->
        value = - Math.floor(Math.random() * 20) + 10 # [-29;-10]
        res = await chai.request(@httpServer)
          .get("/counter/increment/#{bucket}/#{obj}/#{value}")
        res.should.have.status 200
        res.text.should.be.a 'string'
        res.text.should.equal 'ok'
        res = await chai.request(@httpServer)
          .get("/counter/read/#{bucket}/#{obj}")
        res.should.have.status 200
        res.text.should.be.a 'string'
        parseInt(res.text).should.equal value

      it 'Should stay the same if increment is zero', ->
        res = await chai.request(@httpServer)
          .get("/counter/increment/#{bucket}/#{obj}/0")
        res.should.have.status 200
        res.text.should.be.a 'string'
        res.text.should.equal 'ok'
        res = await chai.request(@httpServer)
          .get("/counter/read/#{bucket}/#{obj}")
        res.should.have.status 200
        res.text.should.be.a 'string'
        parseInt(res.text).should.equal 0
