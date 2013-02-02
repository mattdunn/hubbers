#!/usr/bin/env coffee

request = require('superagent')

require('zappajs') ->
  @get '/hubbers': ->
    getHubbers = (processHubbersCallback) =>
      request
        .get('https://api.github.com/orgs/thoughtworks/members?client_id=' + process.env.HUBBER_GITHUB_CLIENT_ID + '&client_secret=' + process.env.HUBBER_GITHUB_CLIENT_SECRET)
        .end(processHubbersCallback)
    
    processHubbers =  (error, response) =>
      @.json response.body.map((hubber) -> { name: hubber.login })

    getHubbers(processHubbers)
