    module.exports = (antidote) ->

      router = require('express').Router()

      router.get '/read/:bucket/:key', (req, res, next) ->
        antidote.defaultBucket = req.params.bucket
        set = antidote.set req.params.key
        value = await set.read()
        res.send value
        next()

      router.route '/add/:bucket/:key/:elem'
        .get (req, res, next) ->
          elem = String req.params.elem
          antidote.defaultBucket = req.params.bucket
          set = antidote.set req.params.key
          response = await antidote.update set.add elem
          res.send "ok"
          next()
        .put (req, res, next) ->
          elem = String req.params.elem
          antidote.defaultBucket = req.params.bucket
          set = antidote.set req.params.key
          response = await antidote.update set.add elem
          res.send "ok"
          next()
        .post (req, res, next) ->
          elem = String req.params.elem
          antidote.defaultBucket = req.params.bucket
          set = antidote.set req.params.key
          response = await antidote.update set.add elem
          res.send "ok"
          next()

      router.route '/remove/:bucket/:key/:elem'
        .get (req, res, next) ->
          elem = String req.params.elem
          antidote.defaultBucket = req.params.bucket
          set = antidote.set req.params.key
          response = await antidote.update set.remove elem
          res.send "ok"
          next()
        .delete (req, res, next) ->
          elem = String req.params.elem
          antidote.defaultBucket = req.params.bucket
          set = antidote.set req.params.key
          response = await antidote.update set.remove elem
          res.send "ok"
          next()

      return router
