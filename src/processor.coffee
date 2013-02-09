exports.processHubbers =  (hubbers) =>
  hubbers.map((hubber) -> { name: hubber.login })