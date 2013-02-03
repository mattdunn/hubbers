#!/usr/bin/env coffee

request = require('superagent')

port = process.env.PORT or 3000

require('zappajs') port, ->
  @get '/hubbers': ->
    githubClientId = process.env.HUBBER_GITHUB_CLIENT_ID
    githubClientSecret = process.env.HUBBER_GITHUB_CLIENT_SECRET

    getHubbers = (processHubbersCallback) =>
      request
        .get('https://api.github.com/orgs/thoughtworks/members?client_id=#{githubClientId}&client_secret=#{githubClientSecret}')
        .end(processHubbersCallback)
    
    processHubbers =  (error, response) =>
      @.json response.body.map((hubber) -> { name: hubber.login })

    getHubbers(processHubbers)
