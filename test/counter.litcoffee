    ## TODO: fix package.json mocha invocation to implicitly use litcoffee files
    ## TODO: only testing using GET. check using other methods as well!

    server = require '../src/server'
    chai = require 'chai'
    chaiHTTP = require 'chai-http'

    chai.should()
    chai.use(chaiHTTP)

    bucket = 'test'
    obj = 'counter1'

    describe 'Counter', ->

      beforeEach (done) ->
        await chai.request(server)
          .get("/counter/read/#{bucket}/#{obj}").end defer err, res
        value = - parseInt res.text
        await chai.request(server)
          .get("/counter/increment/#{bucket}/#{obj}/#{value}")
          .end defer err, res
        done()

      it 'Should increment by one by default', (done) ->
        await chai.request(server)
          .get("/counter/increment/#{bucket}/#{obj}").end defer err, res
        res.should.have.status 200
        res.text.should.be.a 'string'
        res.text.should.equal 'ok'
        await chai.request(server)
          .get("/counter/read/#{bucket}/#{obj}").end defer err, res
        res.should.have.status 200
        res.text.should.be.a 'string'
        parseInt(res.text).should.equal 1
        done()

      it 'Should increment by amount specified', (done) ->
        value = Math.floor(Math.random() * 20) + 10 # [10;29]
        await chai.request(server)
          .get("/counter/increment/#{bucket}/#{obj}/#{value}").end defer err, res
        res.should.have.status 200
        res.text.should.be.a 'string'
        res.text.should.equal 'ok'
        await chai.request(server)
          .get("/counter/read/#{bucket}/#{obj}").end defer err, res
        res.should.have.status 200
        res.text.should.be.a 'string'
        parseInt(res.text).should.equal value
        done()

      it 'Should decrement if specified amount is negative', (done) ->
        value = - Math.floor(Math.random() * 20) + 10 # [-29;-10]
        await chai.request(server)
          .get("/counter/increment/#{bucket}/#{obj}/#{value}").end defer err, res
        res.should.have.status 200
        res.text.should.be.a 'string'
        res.text.should.equal 'ok'
        await chai.request(server)
          .get("/counter/read/#{bucket}/#{obj}").end defer err, res
        res.should.have.status 200
        res.text.should.be.a 'string'
        parseInt(res.text).should.equal value
        done()

      it 'Should stay the same if increment is zero', (done) ->
        await chai.request(server)
          .get("/counter/increment/#{bucket}/#{obj}/0").end defer err, res
        res.should.have.status 200
        res.text.should.be.a 'string'
        res.text.should.equal 'ok'
        await chai.request(server)
          .get("/counter/read/#{bucket}/#{obj}").end defer err, res
        res.should.have.status 200
        res.text.should.be.a 'string'
        parseInt(res.text).should.equal 0
        done()
