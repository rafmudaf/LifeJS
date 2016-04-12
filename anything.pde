PImage img;

void setup(){
    size( 400, 200 );
    frameRate( 15 );
    
    img = createImage(120, 120, RGB);
    for(int i=0; i < img.pixels.length; i++) {
        img.pixels[i] = color(0, 90, 102, i%img.width * 2); 
    }
}

void draw(){
    background(0,0,255);
    image(img,33,33);
    image(img, mouseX-60, mouseY-60);
}

void mouseMoved(){

}