request = require 'superagent'
async = require 'async'

githubBaseUrl = "https://api.github.com"
githubClientId = process.env.HUBBER_GITHUB_CLIENT_ID
githubClientSecret = process.env.HUBBER_GITHUB_CLIENT_SECRET
githubAuthentication = "?client_id=#{githubClientId}&client_secret=#{githubClientSecret}"
userAgent = 'superagent'

exports.getHubbers = (orgName, callback) =>
  orgMembersPath = "/orgs/#{orgName}/members"
  request
    .get(githubBaseUrl + orgMembersPath + githubAuthentication)
    .set('User-Agent', userAgent)
    .end((error, response) =>
      callback error, response.body
    )

exports.getReposForHubbers = (hubbers, callback) =>
  getReposForHubber = (hubber, callback2) =>
    userReposPath = "/users/#{hubber.name}/repos"
    request
      .get(githubBaseUrl + userReposPath + githubAuthentication)
      .set('User-Agent', userAgent)
      .end((error, response) =>
        callback2 error, { name: hubber.name, repos: response.body}
      )
  async.map(
    hubbers,
    getReposForHubber,
    (error, hubbersWithRepos) => callback error, hubbersWithRepos
  )
