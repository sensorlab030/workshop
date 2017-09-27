var svg = d3.select('svg');
var width = svg.attr('width');
var height = svg.attr('height');

var node;
var color = d3.scaleOrdinal(d3.schemeCategory20);
var simulation = d3
  .forceSimulation()
  .force('charge', d3.forceManyBody().distanceMax(100))
  .force('center', d3.forceCenter(width / 2, height / 2));

var port = 9001; // the port you choose in the SensorBridge setup
var sensor = 1; // which sensor data should be rendered
var radius = 8; // the width of a single node
var socket = new WebSocket('ws://localhost:' + port);

socket.addEventListener('open', function() {
  socket.addEventListener('message', function(e) {
    // convert the incoming string to JSON so we can target a specific sensor
    var value = JSON.parse(e.data)['sensor_' + sensor];
    // create an array based on the sensor value, e.g 0.5 = 50 nodes
    var arr = Array.from({length: Math.round(value * 100)}, function(v, i) {
      return {i};
    });
    update(arr);
  });
});

d3.json('./example-data/miserables.json', function(error, data) {
  if (error) throw error;
  render(data.nodes);
});

function render(data) {
  node = svg
    .append('g')
    .attr('class', 'nodes')
    .selectAll('circle')
    .data(data)
    .enter()
    .append('circle')
    .attr('r', radius)
    .attr('fill', function(d) {
      return color(d.group);
    });

  simulation.nodes(data).on('tick', ticked);
}

function update(data) {
  node = svg.selectAll('circle').data(data);

  node
    .exit()
    .transition()
    .attr('r', 0)
    .remove();

  node
    .enter()
    .append('circle')
    .attr('fill', function(d) {
      return color(d.i);
    })
    .call(function(node) {
      node.transition().attr('r', radius);
    })
    .merge(node);

  // Update and restart the simulation.
  simulation.nodes(data).on('tick', ticked);
  simulation.alpha(1).restart();
}

function ticked() {
  // position the nodes and keep them inside the SVG
  // https://stackoverflow.com/a/9577224
  node
    .attr('cx', function(d) {
      return (d.x = Math.max(radius, Math.min(width - radius, d.x)));
    })
    .attr('cy', function(d) {
      return (d.y = Math.max(radius, Math.min(height - radius, d.y)));
    });
}
