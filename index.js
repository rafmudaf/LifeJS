// This is the custom javscript for index.html

// init function
(function() {
    setCanvasSize(500, 500, 20, 20);
})();

// UI handling
$('#mesh-resolution-slider').slider({
    ticks: [1, 2, 3],
    ticks_labels: ['Coarse', 'Medium', 'Fine'],
    ticks_snap_bounds: 1,
    tooltip: "hide",
    step: 1
}).on('slideStop', updateMeshResolution);

$('#lifesketch').click(paintAPixel);

$('#infinity-button').click(() => { updateStatus('infinitely playing'); });
$('#infinity-button').click(startIteration);

$('#one-button').click(() => { updateStatus('one generation played'); });
$('#one-button').click(oneIteration);

$('#pause-button').click(() => { updateStatus('paused'); });
$('#pause-button').click(stopIteration);

$('#reset-button').click(reset);

// Global variables
var xdim;
var ydim;
var xres;
var yres;
var xpixSize;
var ypixSize;

function updateGenerationCount(gen) {
    $('#genCount').text(gen);
}

function updateStatus(msg) {
    $('#status').text(msg);
}

function setCanvasSize(xdimin, ydimin, xresin, yresin) {
    xdim = xdimin;
    ydim = ydimin;
    xres = xresin;
    yres = yresin;
    xpixSize = xdim/xres;
    ypixSize = ydim/yres;
}

function resolutionMap(index) {
    var map = {
       1: 10,
       2: 25,
       3: 50
    }
    return map[index];
}
function updateMeshResolution() {
    var pjs = Processing.getInstanceById('lifesketch');
    var sliderValue = $('#mesh-resolution-slider').data('slider').getValue();
    var resolution = resolutionMap(sliderValue);
    $('#mesh-resolution-value').text(resolution);
    pjs.updateMeshResolution(resolution);
    pjs.updateMeshResolution(resolution);
    reset();
}

function paintAPixel(e) {
    var pjs = Processing.getInstanceById('lifesketch');
    var mouseXY = getMousePos(document.getElementById('lifesketch'), e);
    var pixelIndex = Math.floor(mouseXY.x/xpixSize)+Math.floor(mouseXY.y/ypixSize)*xres;
    pjs.fillPixel(pixelIndex);
}

function getMousePos(canvas, evt) {
    var rect = canvas.getBoundingClientRect();
    return {
        x: Math.floor(500 * (evt.clientX - rect.left) / rect.height),
        y: Math.floor(500 * (evt.clientY - rect.top) / rect.width)
    }
}

function startIteration() {
    var pjs = Processing.getInstanceById('lifesketch');
    pjs.start();
}

function oneIteration() {
    var pjs = Processing.getInstanceById('lifesketch');
    pjs.runFor(1);
}

function stopIteration() {
    var pjs = Processing.getInstanceById('lifesketch');
    pjs.stop();
}

function reset() {
    var pjs = Processing.getInstanceById('lifesketch');
    pjs.setup();
    updateGenerationCount(0);
}