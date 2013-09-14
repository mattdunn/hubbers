(function($, d3, _) {
  function getHubbers(){
    return $.getJSON('http://hubbers.herokuapp.com/organisation/thoughtworks/languages');
  }

  function drawHubbers(hubbers){
    d3.select("body")
      .append("svg")
        .attr("width", 550)
        .attr("height", 550)
      .selectAll("circle")
      .data(_.sortBy(hubbers, 'count'))
      .enter()
      .append("circle")
        .attr("cy", 150)
        .attr("cx", function(hubber, index){ return (hubber.count / 10) + (index * 10); })
        .attr("r", function(hubber){ return hubber.count / 10; })
        .text(function(hubber){ return hubber.name; });
  }

  $(function() {
    getHubbers().done(drawHubbers);
  });
})(jQuery, d3, _);
