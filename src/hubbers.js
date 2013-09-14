(function($) {
  function getHubbers(){
    return $.getJSON('http://hubbers.herokuapp.com/organisation/thoughtworks/languages');
  }

  function drawHubbers(hubbers){
    d3.select("body")
      .append("svg")
        .attr("width", 1550)
        .attr("height", 1550)
      .selectAll("circle")
      .data(hubbers)
      .enter()
      .append("circle")
        .attr("cy", 10)
        .attr("cx", 20)
        .attr("r", function(hubber){ return hubber.count / 20; })
        .text(function(hubber){ return hubber.name; });
  }

  $(function() {
    getHubbers().done(drawHubbers);
  });
})(jQuery);
