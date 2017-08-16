    ## TODO: only testing using GET. check using other methods as well!

    server = require '../src/server'
    chai = require 'chai'
    chaiHTTP = require 'chai-http'

    chai.should()
    chai.use(chaiHTTP)

    bucket = 'test'
    obj = 'register1'

    randomString = (length) ->
      Math.round(
        (Math.pow(36, length + 1) - Math.random() * Math.pow(36, length)))
        .toString(36).slice(1)

    describe 'Register', ->

      beforeEach (done) ->
        done()

      it 'Should be able to set it to any value', (done) ->
        value = randomString(10)
        await chai.request(server)
          .get("/register/set/#{bucket}/#{obj}/#{value}").end defer err, res
        res.should.have.status 200
        res.text.should.be.a 'string'
        res.text.should.equal 'ok'
        await chai.request(server)
          .get("/register/read/#{bucket}/#{obj}").end defer err, res
        res.should.have.status 200
        res.text.should.be.a 'string'
        res.text.should.equal value
        done()
