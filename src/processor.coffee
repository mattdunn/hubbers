exports.processHubbers =  (hubbers, callback) =>
  callback null, hubbers.map((hubber) -> { name: hubber.login })
