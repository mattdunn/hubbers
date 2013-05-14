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
      resolvedLanguage = findOrAddToArray(languages, language, {name: language.name})
      resolvedLanguage.count += 1
      languages
    ,[]
  )

findOrAddToArray = (array, elementToAdd, predicate) ->
  element = _.find(array, predicate)
  array.push elementToAdd if !element
  _.find(array, predicate)

exports.transform = (hubbers, callback) =>
  languages = languagesWithNulls(hubbers)
  languages = languagesWithoutNulls(languages)
  languages = languagesWithoutDuplicates(languages)
  callback null, languages
