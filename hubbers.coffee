#!/usr/bin/env coffee
request = require('superagent')
$ = require('jquery');

require('zappajs') ->
  @enable 'default layout'

  @get '/': -> 
    @render 'index'

  @view index: ->
    @title = 'hubbers'

  @post '/analyse': ->
    @send 202

    # http://www.slideshare.net/sebasporto/embracing-async-with-deferreds-and-promises

    def1 = $.Deferred();
    def2 = $.Deferred();

    $.when(def1, def2).done((res1, res2) ->
      console.log(res1)
      console.log(res2) 
    )

    def1.resolve("x")
    def2.resolve("y")

    #use superagent again

    getHubbers = (cb) ->
      request
        .get('https://api.github.com/orgs/thoughtworks/members')
        .end(cb)

    getRepos = (hubber, callback) ->
      request
        #.get('https://api.github.com/users/' + hubber + '/repos')
        #.end(icallback)

    # http://stackoverflow.com/questions/6048504/synchronous-request-in-nodejs
#    step(
#      -> getHubbers(this)
#    , (err, hubbersResponse) ->
#      console.log(hubbersResponse)
 #       getRepos(hubber.login, this.parallel()) for hubber in hubbersResponse.body 
#    , (error, reposResponses) ->
#        for reposResponse in reposResponses
#          console.log(repo) for repo in reposResponse.body 
#    )
