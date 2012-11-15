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
    request
      .get('https://api.github.com/orgs/thoughtworks/members')
      .end((response) -> 
        for member in response.body 
          console.log(member.url) 
      );
