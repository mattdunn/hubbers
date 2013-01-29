#!/usr/bin/env coffee

request = require('superagent')

require('zappajs') ->
  @get '/hubbers': ->
    that = @
    request
      .get('https://api.github.com/orgs/thoughtworks/members?client_id=' + process.env.HUBBER_GITHUB_CLIENT_ID + '&client_secret=' + process.env.HUBBER_GITHUB_CLIENT_SECRET)
      .end((error, hubbers) ->
        that.json(hubbers.body.map((hubber) -> { name: hubber.login }))
      )



