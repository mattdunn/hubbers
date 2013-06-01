#!/usr/bin/env coffee

async = require 'async'
api =  require './api'
transformer =  require './transformer'
hubbersToLanguagesTransformer =  require './hubbers-to-languages-transformer'

port = process.env.PORT or 3000

require('zappajs') port, ->
  @get '/organisation/:name/languages': ->
    async.waterfall([
      (callback) => api.getHubbers(@params.name, callback)
    , transformer.processHubbers
    , api.getReposForHubbers
    , transformer.processReposForHubbers
    , hubbersToLanguagesTransformer.transform
    ], (error, languages) =>
      @json languages
    )
