request = require 'superagent'

githubBaseUrl = "https://api.github.com"
githubClientId = process.env.HUBBER_GITHUB_CLIENT_ID
githubClientSecret = process.env.HUBBER_GITHUB_CLIENT_SECRET
githubAuthentication = "?client_id=#{githubClientId}&client_secret=#{githubClientSecret}"

exports.getHubbers = (callback) =>
  orgMembersPath = "/orgs/thoughtworks/members"
  request
    .get(githubBaseUrl + orgMembersPath + githubAuthentication)
    .end((error, response) =>
      callback error, response.body
    )
