vows = require 'vows'
should = require 'should'
request = require 'superagent'
app = require '../src/app'

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
  .describe('/organisation')
  .addBatch
    'when GET /organisation/thoughtworks/languages': {
       topic:  =>
         api.get('/organisation/thoughtworks/languages')
      'json should be returned': (error, response) =>
        response.should.be.json
      'each language should have a name': (error, response) =>
        language.should.have.property('name') for language in response.body
      'each language should have a count': (error, response) =>
        language.should.have.property('count') for language in response.body
    }
  .export(module)
