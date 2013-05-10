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
  _.reduce(languagesWithDuplicates,
           (accum, language) ->
             language2 = _.find(accum, {name: language.name})
             if(!language2)
               accum.push(language)
               language2 = language
             language2.count = language2.count + 1
             accum
           ,[]
  )

exports.transform = (hubbers, callback) =>
  languages = languagesWithNulls(hubbers)
  x2 = languagesWithoutNulls(languages)
  x3 = languagesWithoutDuplicates(x2)
  callback null, languagesWithoutNulls(x3)
