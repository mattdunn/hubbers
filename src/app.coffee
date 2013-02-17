#!/usr/bin/env coffee

async = require 'async'
api =  require './github-api'
processor =  require './processor'

port = process.env.PORT or 3000

require('zappajs') port, ->
  @get '/organisation/:name/hubbers': ->
    async.waterfall([
      (callback) => api.getHubbers(@params.name, callback)
    , processor.processHubbers
    , api.getReposForHubbers
    , processor.processReposForHubbers
    ], (error, hubbers) =>
      @json hubbers
    )
  @get '/organisation/:name/languages': ->
    async.waterfall([
      (callback) => api.getHubbers(@params.name, callback)
    , processor.processHubbers
    , api.getReposForHubbers
    , processor.processReposForHubbers
    , processor.processLanguagesForHubbers
    ], (error, languages) =>
      @json languages
    )
