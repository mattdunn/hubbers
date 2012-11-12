#!/usr/bin/env coffee

require('zappajs') ->
  @enable 'default layout'

  @get '/': -> 
    @render 'index'

  @view index: ->
    @title = 'hubbers'
