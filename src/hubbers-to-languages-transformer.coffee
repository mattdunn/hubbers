_ = require 'lodash'

languagesWithNulls = (hubbers) ->
  _.flatten hubbers.map((hubber) ->
    hubber.repos.map((repo)->
      name: repo.language,
      count: 0
    ))

languagesWithoutNulls = (languagesWithNulls) ->
  _.filter languagesWithNulls, (language) -> language.name?

languagesWithoutDuplicates = (languagesWithDuplicates) ->
  _.reduce(
    languagesWithDuplicates,
    (languages, language) ->
      language2 = _.find(languages, {name: language.name})
      if(!language2)
        languages.push language
        language2 = language
      language2.count = language2.count + 1
      languages
    ,[]
  )

exports.transform = (hubbers, callback) =>
  languages = languagesWithNulls(hubbers)
  languages = languagesWithoutNulls(languages)
  languages = languagesWithoutDuplicates(languages)
  callback null, languages
