vows = require 'vows'
should = require 'should'
processor = require '../src/processor'

vows
  .describe('processor')
  .addBatch
    'when processing hubbers': {
       topic:  =>
         hubbers =
           login: "test-name"
         processor.processHubbers(hubbers)
      'each processed hubber should have a name': (processedHubbers) =>
        hubber.name.should.not.be.empty for hubber in processedHubbers
    }
  .export(module)
