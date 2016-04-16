PImage img;
int xdim = 500;
int ydim = 500;
int xres = 20;
int yres = 20;
int xpixSize = xdim/xres;
int ypixSize = ydim/yres;
LifePixel[] oldPixels = new LifePixel[xres*yres];
LifePixel[] newPixels = new LifePixel[xres*yres];
bool go;

void setup(){
    size(xdim, ydim);
    frameRate( 10 );
    go = false;
    img = createImage(xdim, ydim, RGB);

    // instantiate the pixel array
    for (int i=0; i<xres*yres; i++) {
        newPixels[i] = new LifePixel(1);
        fillPixel(i);
    }
}

void fillPixel(int index) {
    int rowsBefore = floor(index/xres);
    int columnsBefore = index - rowsBefore*xres;

    // turn pixel off
    if (newPixels[index].isAlive()) {
        for (int j=0; j<ypixSize; j++) {
            int pixelsBefore = rowsBefore*xdim*ypixSize + columnsBefore*xpixSize + j*xdim;
            for (int i=0; i<xpixSize; i++) {
                if (j==0 || j==ypixSize-1 || i==0 || i==xpixSize-1) {
                    img.pixels[i+pixelsBefore] = color(30,30,30);
                } else {
                    img.pixels[i+pixelsBefore] = color(0,0,0);
                }
            }
        }
        newPixels[index] = new LifePixel(0);

    // turn pixel on
    } else {
        for (int j=0; j<ypixSize; j++) {
            int pixelsBefore = rowsBefore*xdim*ypixSize + columnsBefore*xpixSize + j*xdim;
            for (int i=0; i<xpixSize; i++) {
                if (j==0 || j==ypixSize-1 || i==0 || i==xpixSize-1) {
                    img.pixels[i+pixelsBefore] = color(70,20,70);
                } else {
                    img.pixels[i+pixelsBefore] = color(255,0,255);
                }
            }
        }
        newPixels[index] = new LifePixel(1);
    }
}

void draw(){
    image(img,0,0);

    if (go) {
        TheGameOfLife();
    }
}

//void mouseClicked() {
//    int pixelIndex = floor(mouseX/xpixSize)+floor(mouseY/ypixSize)*xres;
//    fillPixel(pixelIndex);
//}

//void keyPressed() {
//    if (go) {
//        go = false;
//    } else {
//        go = true;
//    }
//}

void start() { go = true; }
void stop() { go = false; }

void TheGameOfLife() {
    arrayCopy(newPixels, oldPixels);

    for (int i=0; i < xres*yres; i++) {

        int count = 0;

        if (i<xres) {                   // skip the top row
            continue;
        } else if (i%xres == 0) {       // skip the left side
            continue;
        } else if ((i+1)%xres == 0) {   // skip the right side
            continue;
        } else if (i > xres*(yres-1)) { // skip the bottom row
            continue;
        }

        let leftdown = i+xres-1;
        let left = i-1;
        let leftup = i-xres-1;
        let up = i-xres;
        let rightup = i-xres+1;
        let right = i+1;
        let rightdown = i+xres+1;
        let down = i+xres

        count += oldPixels[leftdown].value;
        count += oldPixels[left].value;
        count += oldPixels[leftup].value;
        count += oldPixels[up].value;
        count += oldPixels[rightup].value;
        count += oldPixels[right].value;
        count += oldPixels[rightdown].value;
        count += oldPixels[down].value;

        // Any live cell with fewer than two live neighbours dies, as if caused by under-population.
        // Any live cell with more than three live neighbours dies, as if by over-population.
        // Any live cell with two or three live neighbours lives on to the next generation.
        if ((count == 2 || count == 3) && oldPixels[i].isAlive()) {
            // pixel stays alive
            continue;
            //fillPixel(i);
            //newPixels[i] = new LifePixel(1);
        } else if (oldPixels[i].isAlive()) {
            // pixel dies
            fillPixel(i);
            newPixels[i] = new LifePixel(0);
        }

        // Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
        if (count == 3 && !oldPixels[i].isAlive()) {
            fillPixel(i);
            newPixels[i] = new LifePixel(1);
        }
    }
}

class LifePixel {
    int value;

    LifePixel() {
    }

    LifePixel(int value) {
        this.value = value;
    }

    bool isAlive() {
        return (this.value == 1);
    }
}