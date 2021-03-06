vows = require 'vows'
should = require 'should'
transformer = require '../src/transformer'

vows
  .describe('transformer')
  .addBatch
    'when processing hubbers': {
      topic: ->
        hubbers = [
          {login: "test-name"}
        ]
        transformer.processHubbers(hubbers, this.callback)
      'each processed hubber should have a name': (error, processedHubbers) =>
        hubber.name.should.equal("test-name") for hubber in processedHubbers
    },
    'when processing repos for hubbers': {
      topic:  ->
        reposForHubbers = [
          name: "test-name"
          repos: [
            name: "test-repo",
            language: "test-language"
          ]
        ]
        transformer.processReposForHubbers(reposForHubbers, @callback)
      'each processed hubber should have a name': (error, processedHubbers) =>
         hubber.name.should.equal("test-name") for hubber in processedHubbers
      'each processed repo for hubber should have a name': (error, processedHubbers) =>
        processedHubbers.forEach (hubber) ->
          repo.name.should.equal("test-repo") for repo in hubber.repos
      'each processed repo for hubber should have a language': (error, processedHubbers) =>
        processedHubbers.forEach (hubber) ->
          repo.language.should.equal("test-language") for repo in hubber.repos
    }
  .export(module)
