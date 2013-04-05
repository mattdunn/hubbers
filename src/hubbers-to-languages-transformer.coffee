_ = require 'lodash'

languagesWithNulls = (hubbers) ->
  _.flatten hubbers.map((hubber) ->
    hubber.repos.map((repo)->
      name: repo.language
    ))

languagesWithoutNulls = (languagesWithNulls) ->
  _.filter languagesWithNulls, (language) -> language.name?

exports.transform = (hubbers, callback) =>
  languages = languagesWithNulls(hubbers)
  callback null, languagesWithoutNulls(languages)