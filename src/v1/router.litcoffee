    module.exports = (antidote) ->
      router = require('express').Router()
      router.use '/counter', require('./counter')(antidote)
      router.use '/integer', require('./integer')(antidote)
      router.use '/register', require('./register')(antidote)
      router.use '/mvregister', require('./mvregister')(antidote)
      router.use '/set', require('./set')(antidote)
      return router
