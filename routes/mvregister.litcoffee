    module.exports = (webserver, antidote) ->

      router = require('express').Router()

      router.get '/read/:bucket/:key', (req, res, next) ->
        antidote.defaultBucket = req.params.bucket
        mvregister = antidote.multiValueRegister req.params.key
        await mvregister.read().then defer value
        res.send String value
        next()

      router.get '/set/:bucket/:key/:value', (req, res, next) ->
        value = String req.params.value
        antidote.defaultBucket = req.params.bucket
        mvregister = antidote.multiValueRegister req.params.key
        await antidote.update(mvregister.set(value)).then defer response
        res.send "ok"
        next()

      return router
