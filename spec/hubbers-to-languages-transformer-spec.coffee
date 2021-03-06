vows = require 'vows'
should = require 'should'
transformer = require '../src/hubbers-to-languages-transformer'

vows
  .describe('hubbersToLanguagesTransformer')
  .addBatch
    'when transforming hubbers into languages': {
      topic:  ->
        reposForHubbers = [
          name: "test-name"
          repos: [
            { language: "test-language" },
            { language: null }
          ]
        ]
        transformer.transform(reposForHubbers, @callback)
      'each language should have a name': (error, languages) =>
         language.should.have.property("name") for language in languages
      'null languages should be filtered out': (error, languages) =>
         language.name.should.not.be.null for language in languages
      'each language should have a count': (error, languages) =>
         language.should.have.property("count") for language in languages
    },
    'when transforming one language': {
      topic:  ->
        reposForHubbers = [
          name: "test-name"
          repos: [
            { language: "test-language" },
          ]
        ]
        transformer.transform(reposForHubbers, @callback)
      'the count should be one': (error, languages) =>
         language.count.should.equal(1) for language in languages
    },
    'when transforming a language that occurs more than once': {
      topic:  ->
        reposForHubbers = [
          {
            name: "test-name"
            repos: [
              { language: "test-language" },
            ]
          },
          {
            name: "another-test-name"
            repos: [
              { language: "test-language" },
            ]
          }
        ]
        transformer.transform(reposForHubbers, @callback)
      'the transformed language should appear exactly once': (error, languages) =>
         (language for language in languages when language.name == 'test-language').length.should.equal(1)
      'the count should be two': (error, languages) =>
         language.count.should.equal(2) for language in languages
    }
  .export(module)
