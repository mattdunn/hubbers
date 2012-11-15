#!/usr/bin/env coffee
request = require('superagent')
step = require('step')

require('zappajs') ->
  @enable 'default layout'

  @get '/': -> 
    @render 'index'

  @view index: ->
    @title = 'hubbers'

  @post '/analyse': ->
    @send 202

    getHubbers = ->
      request
        .get('https://api.github.com/orgs/thoughtworks/members')
        .end((response) ->
          hubbers = (member.login for member in response.body)
          return hubbers[0] 
        )

    getRepos = (error, hubber) ->
      request
        .get('https://api.github.com/users/' + hubber + '/repos')
        .end((response) ->
          console.log(repo) for repo in response.body
        )

    # this doesnt work as running the two functions just queues the ajax calls and returns immediaetly, not with return value of ajax call
    step(getHubbers,getRepos)
