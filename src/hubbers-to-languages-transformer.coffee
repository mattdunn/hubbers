_ = require 'lodash'

exports.transform = (hubbers, callback) =>
  languagesWithNulls =
    _.flatten hubbers.map((hubber) ->
      hubber.repos.map((repo)->
        name: repo.language
      ))
  languagesWithoutNulls = _.filter languagesWithNulls, (language) -> language.name?

  callback null, languagesWithoutNulls
