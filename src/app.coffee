#!/usr/bin/env coffee

async = require 'async'
api =  require './github-api'
processor =  require './processor'

port = process.env.PORT or 3000

require('zappajs') port, ->
  @get '/hubbers': ->
    async.waterfall([
      api.getHubbers
    , processor.processHubbers
    , api.getReposForHubbers
    , processor.processReposForHubbers
    ], (error, hubbers) =>
      @json hubbers
    )
