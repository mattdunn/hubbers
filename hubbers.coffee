#!/usr/bin/env coffee

request = require('superagent')

port = process.env.PORT or 3000

require('zappajs') port, ->
  @get '/hubbers': ->
    githubBaseUrl = "https://api.github.com"
    githubClientId = process.env.HUBBER_GITHUB_CLIENT_ID
    githubClientSecret = process.env.HUBBER_GITHUB_CLIENT_SECRET
    githubAuthentication = "?client_id=#{githubClientId}&client_secret=#{githubClientSecret}"

    getHubbers = (processHubbersCallback) =>
      orgMembersPath = "/orgs/thoughtworks/members"
      request
        .get(githubBaseUrl + orgMembersPath + githubAuthentication)
        .end(processHubbersCallback)
    
    processHubbers =  (error, response) =>
      @.json response.body.map((hubber) -> { name: hubber.login })

    getHubbers(processHubbers)
