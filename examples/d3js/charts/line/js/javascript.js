var svg = d3.select('svg');
var margin = {top: 20, right: 20, bottom: 20, left: 40};
var width = svg.attr('width') - margin.left - margin.right;
var height = svg.attr('height') - margin.top - margin.bottom;
var g = svg
  .append('g')
  .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

var port = 9001; // the port you choose in the SensorBridge setup
var interval = 300; // the capture interval
var sensor = 2; // which sensor data should be rendered
var socket = new WebSocket('ws://localhost:' + port);
var static;

socket.addEventListener('open', function(e) {
  var data = d3.range(40).map(() => 0);
  socket.addEventListener('message', function(event) {
    data.push(JSON.parse(event.data)['sensor_' + sensor]);
  });
  static = false;
  render(40, data);
});

socket.addEventListener('close', function(e) {
  d3.select('.line').remove();

  // location of the mock data, relative to the HTML file.
  d3.csv('./example-data/sound-10ms.csv', function(d) {
    var mock = [];
    for (var i = 0; i < d.length; i++) {
      mock.push(d[i].sensor_1);
    }
    static = true;
    render(mock.length, mock);
  });
});

function render(n, data) {
  var x = d3
    .scaleLinear()
    .domain([0, n - 1])
    .range([0, width]);
  var y = d3
    .scaleLinear()
    .domain([0, 1])
    .range([height, 0]);
  var line = d3
    .line()
    .curve(d3.curveCatmullRom.alpha(0.5))
    .x(function(d, i) {
      return x(i);
    })
    .y(function(d, i) {
      return y(d);
    });

  g
    .append('defs')
    .append('clipPath')
    .attr('id', 'clip')
    .append('rect')
    .attr('width', width)
    .attr('height', height);
  g
    .append('g')
    .attr('class', 'axis axis--x')
    .attr('transform', 'translate(0,' + y(0) + ')')
    .call(d3.axisBottom(x))
    .remove();
  g
    .append('g')
    .attr('class', 'axis axis--y')
    .call(d3.axisLeft(y));
  g
    .append('g')
    .attr('clip-path', 'url(#clip)')
    .append('path')
    .datum(data)
    .attr('d', line)
    .attr('class', 'line')
    .transition()
    .duration(interval)
    .ease(d3.easeLinear)
    .on('start', static ? null : tick);

  function tick() {
    // Redraw the line.
    d3
      .select(this)
      .attr('d', line)
      .attr('transform', null);
    // Slide it to the left.
    d3
      .active(this)
      .attr('transform', 'translate(' + x(-1) + ',0)')
      .transition()
      .on('start', tick);

    // Pop the old data point off the front.
    data.shift();
  }
}
