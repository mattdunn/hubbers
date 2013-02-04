vows = require 'vows'
should = require 'should'
request = require 'superagent'
app = require '../hubbers'

api = vows.prepare(
  get: (path, callback) =>
    request
      .get('http://localhost:3000' + path)
      .end((error, response) =>
        callback(error, response)
      )
,
  ['get']
)

vows
  .describe('/hubbers')
  .addBatch
    'when GET /hubbers':
      topic:  =>
        api.get('/hubbers')
      'json should be returned': (error, response) =>
        response.should.be.json
      'each hubber should have a name': (response) =>
        hubber.name.should.not.be.empty for hubber in response.body
  .export(module)
