vows = require 'vows'
assert = require 'assert'

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
        assert.equal hubber.name, 'elvis' for hubber in hubbers
  .export(module)
