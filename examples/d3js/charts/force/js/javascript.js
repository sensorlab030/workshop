var svg = d3.select('svg');
var width = svg.attr('width');
var height = svg.attr('height');

var color = d3.scaleOrdinal(d3.schemeCategory20);

var simulation = d3
  .forceSimulation()
  .force('charge', d3.forceManyBody().distanceMax(100))
  .force('center', d3.forceCenter(width / 2, height / 2));

var port = 9001; // the port you choose in the SensorBridge setup
var sensor = 2; // which sensor data should be rendered
var socket = new WebSocket('ws://localhost:' + port);

socket.addEventListener('open', function() {
  socket.addEventListener('message', function(e) {
    var value = JSON.parse(e.data)['sensor_' + sensor];
    var arr = Array.from({length: Math.round(value * 100)}, (v, i) => {
      return {i};
    });
    update(arr);
  });
});

// socket.addEventListener('close', function() {
d3.json('./example-data/miserables.json', function(error, data) {
  if (error) throw error;
  render(data.nodes);
});
// });

// svg.append('g').attr('class', 'nodes');

function render(data) {
  var node = svg
    .append('g')
    .attr('class', 'nodes')
    .selectAll('circle')
    .data(data)
    .enter()
    .append('circle')
    .attr('r', 8)
    .attr('fill', function(d) {
      return color(d.group);
    })
    .call(
      d3
        .drag()
        .on('start', dragstarted)
        .on('drag', dragged)
        .on('end', dragended)
    );

  simulation.nodes(data).on('tick', ticked);

  function ticked() {
    node
      .attr('cx', function(d) {
        return d.x;
      })
      .attr('cy', function(d) {
        return d.y;
      });
  }
}

function update(data) {
  var node = svg
    .select('.nodes')
    .selectAll('circle')
    .data(data);

  node
    .enter()
    .append('circle')
    .attr('r', 8)
    .attr('fill', function(d) {
      return color(d.i);
    });

  simulation.nodes(data).on('tick', ticked);
  node.exit().remove();
  simulation.restart();

  function ticked() {
    node
      .attr('cx', function(d) {
        return d.x;
      })
      .attr('cy', function(d) {
        return d.y;
      });
  }
}

function dragstarted(d) {
  if (!d3.event.active) simulation.alphaTarget(0.3).restart();
  d.fx = d.x;
  d.fy = d.y;
}

function dragged(d) {
  d.fx = d3.event.x;
  d.fy = d3.event.y;
}

function dragended(d) {
  if (!d3.event.active) simulation.alphaTarget(0);
  d.fx = null;
  d.fy = null;
}
