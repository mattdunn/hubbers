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
    'when GET /organisation/thoughtworks/hubbers': {
       topic:  =>
         api.get('/organisation/thoughtworks/hubbers')
      'json should be returned': (error, response) =>
        response.should.be.json
      'each hubber should have a name': (error, response) =>
        hubber.name.should.not.be.empty for hubber in response.body
      'each hubber should have repos': (error, response) =>
        hubber.should.have.property('repos') for hubber in response.body
      'each hubbers repo should have a name': (error, response) =>
        response.body.forEach (hubber) ->
          repo.name.should.not.be.empty for repo in hubber.repos
    }
  .export(module)
