_ = require 'lodash'

exports.processHubbers =  (hubbers, callback) =>
  callback null, hubbers.map((hubber) -> { name: hubber.login })

exports.processReposForHubbers =  (reposForHubbers, callback) =>
  callback null,
    reposForHubbers.map((hubber) ->
      name: hubber.name
      repos: hubber.repos.map((repo) ->
        name: repo.name
        language: repo.language
      ))

exports.processLanguagesForHubbers = (hubbers, callback) =>
  languages = _.flatten hubbers.map((hubber) ->
      hubber.repos.map((repo)->
        name: repo.language
      ))
  callback null, _.filter languages, (language) -> language.name?
