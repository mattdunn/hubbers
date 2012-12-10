#!/usr/bin/env coffee

request = require('superagent')
async = require('async')

require('zappajs') ->
  @enable 'default layout'

  @get '/': -> 
    @render 'index'

  @view index: ->
    @title = 'hubbers'

  @post '/analyse': ->
    @send 202

    getHubbers = (processHubbers) ->
      request
        .get('https://api.github.com/orgs/thoughtworks/members')
        .end((error, hubbers) ->
          processHubbers(hubbers.body)
        )

    processHubbers = (hubbers) ->
      for hubber in hubbers
        getRepos = hubbers.map((hubber) -> 
          (callback) ->
            request
              .get('https://api.github.com/users/' + hubber.login + '/repos')
              .end((error, repos) -> 
                callback(null, repos)
              )
        )
        async.parallel(
          getRepos,
          (err, repos) ->
            console.log results.length 
        )

    getHubbers(processHubbers)

    # rate limited to 60 requests per hour for unauthenticated requests
    # http://developer.github.com/v3/#rate-limiting
