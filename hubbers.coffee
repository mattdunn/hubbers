#!/usr/bin/env coffee
request = require('superagent')

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
          getRepos(hubbers[0]) 
        )

    getRepos = (hubber) ->
      request
        .get('https://api.github.com/users/' + hubber + '/repos')
        .end((response) ->
          console.log(repo) for repo in response.body
        )

    getHubbers()
