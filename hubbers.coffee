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
        .get('https://api.github.com/orgs/thoughtworks/members?client_id=' + process.env.HUBBER_GITHUB_CLIENT_ID + '&client_secret=' + process.env.HUBBER_GITHUB_CLIENT_SECRET)
        .end((error, hubbers) ->
          processHubbers(hubbers.body)
        )

    processHubbers = (hubbers) ->
      getRepos = hubbers.map((hubber) -> 
        (callback) ->
          request
            .get('https://api.github.com/users/' + hubber.login + '/repos?client_id=' + process.env.HUBBER_GITHUB_CLIENT_ID + '&client_secret=' + process.env.HUBBER_GITHUB_CLIENT_SECRET)
            .end((error, repos) -> 
              callback(null, repos)
            )
      )
      async.parallel(
        getRepos,
        (err, repoResponses) ->
          repos = []
          processRepos(repo.body, repos) for repo in repoResponses
          console.log repos[0]
          console.log repos.length 
      )

    processRepos = (repos, allRepos)->
      allRepos.push(repo) for repo in repos

    getHubbers(processHubbers)

    # rate limited to 60 requests per hour for unauthenticated requests
    # http://developer.github.com/v3/#rate-limiting
