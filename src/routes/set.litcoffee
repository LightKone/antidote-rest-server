    module.exports = (webserver, antidote) ->

      router = require('express').Router()

      router.get '/read/:bucket/:key', (req, res, next) ->
        antidote.defaultBucket = req.params.bucket
        set = antidote.set req.params.key
        await set.read().then defer value
        res.send value
        next()

      router.get '/add/:bucket/:key/:elem', (req, res, next) ->
        elem = String req.params.elem
        antidote.defaultBucket = req.params.bucket
        set = antidote.set req.params.key
        await antidote.update(set.add(elem)).then defer response
        res.send "ok"
        next()

      router.get '/remove/:bucket/:key/:elem', (req, res, next) ->
        elem = String req.params.elem
        antidote.defaultBucket = req.params.bucket
        set = antidote.set req.params.key
        await antidote.update(set.remove(elem)).then defer response
        res.send "ok"
        next()

      return router
