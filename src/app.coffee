#!/usr/bin/env coffee

api =  require './github-api'
processor =  require './processor'

port = process.env.PORT or 3000

require('zappajs') port, ->
  @get '/hubbers': ->
    api.getHubbers((hubbers) => 
      @json processor.processHubbers(hubbers)
    )
