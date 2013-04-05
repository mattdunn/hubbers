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
    }
  .export(module)
