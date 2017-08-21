// This is the custom javscript for index.html

// init function
(function() {
    setCanvasSize(500, 500, 20, 20);
})();

// UI handling
$('#mesh-resolution-slider').slider({
}).on('slideStop', updateMesh);

$('#lifesketch').click(paintAPixel);

$('#infinity-button').click(() => { updateStatus('infinitely playing'); });
$('#infinity-button').click(startIteration);

$('#one-button').click(() => { updateStatus('one generation played'); });
$('#one-button').click(oneIteration);

$('#pause-button').click(() => { updateStatus('paused'); });
$('#pause-button').click(stopIteration);

$('#reset-button').click(reset);


// var xdim = 500;
// var ydim = 500;
// var xres = 20;
// var yres = 20;
// var xpixSize = xdim/xres;
// var ypixSize = ydim/yres;
var xdim;
var ydim;
var xres;
var yres;
var xpixSize;
var ypixSize;
var paused;

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

function updateMesh() {
    var pjs = Processing.getInstanceById('lifesketch');
    
    var xcount = $("#x-resolution-slider").data("slider").getValue();
    var ycount = $("#y-resolution-slider").data("slider").getValue();
    var resolution;

    // console.log(xcount, ycount);
    
    if (500 % xcount !== 0) {
        for (var i=0; i<500; i++) {
            xcount = xcount + 1;
            if (500 % xcount === 0) {
                break;
            }
        }
    }
    resolution = 500 / xcount;
    $('#mesh-resolution-value').text(resolution);
    pjs.updateMesh(0, resolution);

    if (500 % ycount !== 0) {
        for (var i=0; i<500; i++) {
            ycount = ycount + 1;
            if (500 % ycount === 0) {
                break;
            }
        }
    }
    resolution = 500 / ycount;
    $("#y-resolution-value").text(resolution);
    pjs.updateMesh(1, resolution);
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