PImage img;
int xdim = 500;
int ydim = 500;
int xres = 20;
int yres = 20;
int xpixSize = xdim/xres;
int ypixSize = ydim/yres;
lifePixel[] pixels = new lifePixel[xres*yres];

void setup(){
    size(xdim, ydim);
    frameRate( 20 );
    img = createImage(xdim, ydim, RGB);

    for (int i=0; i<xres*yres; i++) {
        pixels[i] = new lifePixel( 1 );
    }

    fillPixel(0, 1);
}

void fillPixel(int index, int onoroff) {
    int rowsBefore = floor(index/xres);
    int columnsBefore = index - rowsBefore*xres;
    for (int j=0; j<ypixSize; j++) {
        int pixelsBefore = rowsBefore*xdim*ypixSize + columnsBefore*xpixSize + j*xdim;
        for (int i=0; i<xpixSize; i++) {
            if (onoroff) {
                img.pixels[i+pixelsBefore] = color(255,0,0);
            } else {
                img.pixels[i+pixelsBefore] = color(0,0,0);
            }
            //if (onoroff) {
            //    img.pixels[i+pixelsBefore+rowsBefore] = color(255,0,0);
            //} else {
            //    img.pixels[i+pixelsBefore+rowsBefore] = color(0,0,0);
            //}
        }
    }
}

void draw(){
    background(0,0,0);
    image(img,0,0);
    //image(img, mouseX-10, mouseY-10);
}

void mousePressed() {
    int pixelIndex = floor(mouseX/xpixSize)+floor(mouseY/ypixSize)*xres;
    //print(mouseY);
    //print(" ");
    //print(ypixSize);
    //print(" ");
    //print(xres);
    //print(" ");
    //println(pixelIndex);
    fillPixel(pixelIndex, 1);
}

class lifePixel {
    int pixWidth;
    int pixHeight;
    int[] globalPixelIndeces = new int[xpixSize*ypixSize];

    lifePixel(int onoroff) {
        int onoroff = onoroff;
    }
}