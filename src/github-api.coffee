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

exports.getReposForHubbers = (hubbers, callback) =>
  hubber = hubbers[0]
  userReposPath = "/users/#{hubber.name}/repos"
  request
    .get(githubBaseUrl + userReposPath + githubAuthentication)
    .end((error, response) =>
      callback error, [{ name: hubber.name, repos: response.body}]
    )
