vows = require 'vows'
should = require 'should'
processor = require '../src/processor'

vows
  .describe('processor')
  .addBatch
    'when processing hubbers': {
      topic: ->
        hubbers = [
          {login: "test-name"}
        ]
        processor.processHubbers(hubbers, this.callback)
      'each processed hubber should have a name': (error, processedHubbers) =>
        hubber.name.should.not.be.empty for hubber in processedHubbers
    },
    'when processing repos for hubbers': {
       topic:  ->
         reposForHubbers = [
           name: "test-name"
           repos: [
             name: "firstRepo"
           ]
         ]
         processor.processReposForHubbers(reposForHubbers, @callback)
      'each processed repo for hubber should have a name': (error, processedHubbers) =>
        hubber.name.should.not.be.empty for hubber in processedHubbers
    }
  .export(module)
