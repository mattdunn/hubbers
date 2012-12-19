vows = require 'vows'
should = require 'should'

resource = 
  get: (uri) ->
    [{name: 'elvis'}]

vows
  .describe('/hubbers')
  .addBatch
    'when GET /hubbers':
      topic: ->
        resource.get('/hubbers')
      'then each hubber should have a name': (hubbers) ->
        hubber.name.should.not.be.empty for hubber in hubbers
  .export(module)
