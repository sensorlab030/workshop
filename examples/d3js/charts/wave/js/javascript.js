var svg = d3.select('svg'),
  width = +svg.attr('width'),
  height = +svg.attr('height'),
  angles = d3.range(0, 2 * Math.PI, Math.PI / 100);

// the port you choose in the SensorBridge setup
var port = 9001;
var socket = new WebSocket('ws://localhost:' + port);
var indeterminate = true;
var path;

socket.addEventListener('open', function() {
  indeterminate = false;
  socket.addEventListener('message', function(e) {
    var data = JSON.parse(e.data);
    update([data.sensor_1 || 0, data.sensor_2 || 0, data.sensor_3 || 0]);
  });
});
// color of the lines associated with the sensors.
// the first in the array becomes the color of sensor_1 etc.
var color = ['cyan', 'magenta', 'yellow'];
// in case you change the colors, this will update the legend.
Array.from(document.querySelectorAll('li span')).map(function(el, i) {
  el.style.backgroundColor = color[i];
});

path = svg
  .append('g')
  .attr('transform', 'translate(' + width / 2 + ',' + height / 2 + ')')
  .attr('fill', 'none')
  .attr('stroke-width', 10)
  .attr('stroke-linejoin', 'round')
  .selectAll('path')
  // values for the indeterminate state
  .data([0.1, 0.1, 0.1])
  .enter()
  .append('path')
  .attr('stroke', function(data, i) {
    return color[i];
  })
  .style('mix-blend-mode', 'darken')
  .datum(function(d, i) {
    return lineGenerator(d, i);
  })
  .attr('d', function(d) {
    return d(angles);
  });

if (indeterminate) {
  d3.timer(function() {
    path.attr('d', function(d) {
      return d(angles);
    });
  });
}

function update(data) {
  path = svg
    .selectAll('path')
    .data(data)
    .datum(function(d, i) {
      return lineGenerator(d, i);
    });

  path
    .transition()
    .duration(100)
    .attr('d', function(d) {
      return d(angles);
    });
}

function lineGenerator(d, i) {
  return d3
    .lineRadial()
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
}
