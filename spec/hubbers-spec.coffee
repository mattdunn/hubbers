vows = require 'vows'
should = require 'should'
request = require 'superagent'
app = require '../hubbers'

api = 
  get: (path) ->
    request.get('http://localhost:3000/' + path).end(this.callback)

vows
  .describe('/hubbers')
  .addBatch
    'when GET /hubbers':
      topic: () -> 
        api.get('/hubbers')
      'each hubber should have a name': (response) ->
        console.log response.status
        #hubber.name.should.not.be.empty for hubber in response.body
  .export(module)
