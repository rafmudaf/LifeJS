PImage img;
int xdim = 500;
int ydim = 500;
int xres = 10;
int yres = 10;
int xpixSize = xdim/xres;
int ypixSize = ydim/yres;
lifePixel[] lifePixels = new lifePixel[xres*yres];

void setup(){
    size(xdim, ydim);
    frameRate( 20 );
    img = createImage(xdim, ydim, RGB);

    for (int i=0; i<xres*yres; i++) {
        lifePixels[i] = new lifePixel(false);
    }
}

void fillPixel(int index) {
    int rowsBefore = floor(index/xres);
    int columnsBefore = index - rowsBefore*xres;

    //fill(color(255,0,0));
    //rect(columnsBefore*xpixSize, rowsBefore*ypixSize, xpixSize, ypixSize);

    if (lifePixels[index].isAlive()) {
        for (int j=0; j<ypixSize; j++) {
            int pixelsBefore = rowsBefore*xdim*ypixSize + columnsBefore*xpixSize + j*xdim;
            for (int i=0; i<xpixSize; i++) {
                img.pixels[i+pixelsBefore] = color(0,0,0);
                lifePixels[index] = new lifePixel(false);
            }
        }
    } else {
        for (int j=0; j<ypixSize; j++) {
            int pixelsBefore = rowsBefore*xdim*ypixSize + columnsBefore*xpixSize + j*xdim;
            for (int i=0; i<xpixSize; i++) {
                img.pixels[i+pixelsBefore] = color(255,0,0);
                lifePixels[index] = new lifePixel(true);
            }
        }
    }
}

void draw(){
    image(img,0,0);
}

void mousePressed() {
    int pixelIndex = floor(mouseX/xpixSize)+floor(mouseY/ypixSize)*xres;
    fillPixel(pixelIndex);
}

class lifePixel {
    bool alive;

    lifePixel() {
    }

    lifePixel(boolean alive) {
        this.alive = alive;
    }

    bool isAlive() {
        return this.alive;
    }
}