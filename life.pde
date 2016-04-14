PImage img;
int xdim = 500;
int ydim = 500;
int xres = 50;
int yres = 50;
int xpixSize = xdim/xres;
int ypixSize = ydim/yres;
LifePixel[] oldPixels = new LifePixel[xres*yres];
LifePixel[] newPixels = new LifePixel[xres*yres];
bool go;

TriangleButton goButton;
RectButton stopButton;

void setup(){
    size(xdim, ydim);
    frameRate( 10 );
    img = createImage(xdim, ydim, RGB);

    // instantiate the pixel array
    for (int i=0; i<xres*yres; i++) {
        newPixels[i] = new LifePixel(1);
        fillPixel(i);
    }

    // Define and create stop and go buttons
    color buttoncolor = color(204);
    color highlight = color(153);
    goButton = new TriangleButton(30, 30, buttoncolor, highlight);
    stopButton = new RectButton(150, 20, 100, buttoncolor, highlight);

    go = false;
}

void fillPixel(int index) {
    int rowsBefore = floor(index/xres);
    int columnsBefore = index - rowsBefore*xres;

    //fill(color(255,0,0));
    //rect(columnsBefore*xpixSize, rowsBefore*ypixSize, xpixSize, ypixSize);

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
                    //img.pixels[i+pixelsBefore] = color(255,0,255);
                } else {
                    //img.pixels[i+pixelsBefore] = color(150,20,150);
                    img.pixels[i+pixelsBefore] = color(255,0,255);
                }
            }
        }
        newPixels[index] = new LifePixel(1);
    }
}

void draw(){
    image(img,0,0);
    //goButton.display();
    //stopButton.display();

    if (go) {
        TheGameOfLife();
    }
}

void mousePressed() {
    int pixelIndex = floor(mouseX/xpixSize)+floor(mouseY/ypixSize)*xres;
    fillPixel(pixelIndex);
}

void keyPressed() {
    if (go) {
        go = false;
    } else {
        go = true;
    }
}

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









void update(int x, int y) {
  if(locked == false) {
    circle1.update();
    circle2.update();
    circle3.update();
    rect1.update();
    rect2.update();
  } else {
    locked = false;
  }

  if(mousePressed) {
    if(circle1.pressed()) {
      currentcolor = circle1.basecolor;
    } else if(circle2.pressed()) {
      currentcolor = circle2.basecolor;
    } else if(circle3.pressed()) {
      currentcolor = circle3.basecolor;
    } else if(rect1.pressed()) {
      currentcolor = rect1.basecolor;
    } else if(rect2.pressed()) {
      currentcolor = rect2.basecolor;
    }
  }
}




class Button {
    int x, y;
    int size;
    color basecolor, highlightcolor;
    color currentcolor;
    boolean over = false;
    boolean pressed = false;

    void update() {
        if(over()) {
            currentcolor = highlightcolor;
        } else {
            currentcolor = basecolor;
        }
    }

    boolean pressed() {
        if(over) {
            locked = true;
            return true;
        } else {
            locked = false;
            return false;
        }
    }

    boolean over() {
        return true;
    }

    boolean overRect(int x, int y, int width, int height) {
        if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
            return true;
        } else {
            return false;
        }
    }

    boolean overTriangle(int x, int y) {
        // obviously, this should be fixed to determine if its in the triangle
        int height = 20;
        int width = 20;
        if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
            return true;
        } else {
            return false;
        }
    }
}



class TriangleButton extends Button {
    TriangleButton(int ix, int iy, color icolor, color ihighlight) {
        x = ix;
        y = iy;
        basecolor = icolor;
        highlightcolor = ihighlight;
        currentcolor = basecolor;
    }

    boolean over() {
        if( overCircle(x, y, size) ) {
            over = true;
            return true;
        } else {
            over = false;
            return false;
        }
    }

    void display() {
        stroke(255);
        fill(currentcolor);
        triangle(x, y, x+20, y, x, y+20);
    }
}

class RectButton extends Button {
    RectButton(int ix, int iy, int isize, color icolor, color ihighlight) {
        x = ix;
        y = iy;
        size = isize;
        basecolor = icolor;
        highlightcolor = ihighlight;
        currentcolor = basecolor;
    }

    boolean over() {
        if( overRect(x, y, size, size) ) {
            over = true;
            return true;
        } else {
            over = false;
            return false;
        }
    }

    void display() {
        stroke(255);
        fill(currentcolor);
        rect(x, y, size, size);
    }
}