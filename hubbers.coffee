#!/usr/bin/env coffee

require('zappajs') ->
  @get '/hubbers': -> 
    @json [{name: 'elvis'}] 
