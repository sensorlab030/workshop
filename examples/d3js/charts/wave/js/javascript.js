var svg = d3.select('svg'),
  width = +svg.attr('width'),
  height = +svg.attr('height'),
  angles = d3.range(0, 2 * Math.PI, Math.PI / 100);

var port = 9001; // the port you choose in the SensorBridge setup
var socket = new WebSocket('ws://localhost:' + port);

socket.addEventListener('open', function(e) {
  socket.addEventListener('message', function(event) {
    var data = JSON.parse(event.data);
    update([data.sensor_1 || 0, data.sensor_2 || 0, data.sensor_3 || 0]);
  });
});

var color = ['cyan', 'magenta', 'yellow'];

var path = svg
  .append('g')
  .attr('transform', 'translate(' + width / 2 + ',' + height / 2 + ')')
  .attr('fill', 'none')
  .attr('stroke-width', 10)
  .attr('stroke-linejoin', 'round')
  .selectAll('path')
  .data([0.1, 0.1, 0.1])
  .enter()
  .append('path')
  .attr('stroke', function(d, i) {
    return color[i];
  })
  .style('mix-blend-mode', 'darken')
  .datum(function(d, i) {
    return d3
      .radialLine()
      .curve(d3.curveLinearClosed)
      .angle(function(a) {
        return a;
      })
      .radius(function(a) {
        var t = d3.now() / 1000;
        return (
          200 +
          Math.cos(a * 8 - d * 2 * Math.PI / 3 + t) *
            Math.pow((1 + Math.cos(a - t)) / 2, 3) *
            d *
            100
        );
      });
  });

d3.timer(function() {
  path.attr('d', function(d) {
    return d(angles);
  });
});

function update(data) {
  svg
    .selectAll('path')
    .data(data)
    .datum(function(d, i) {
      return d3
        .radialLine()
        .curve(d3.curveLinearClosed)
        .angle(function(a) {
          return a;
        })
        .radius(function(a) {
          var t = d3.now() / 1000;
          return (
            200 +
            Math.cos(a * 8 - d * 2 * Math.PI / 3 + t) *
              Math.pow((1 + Math.cos(a - t)) / 2, 3) *
              d *
              100
          );
        });
    });
}
