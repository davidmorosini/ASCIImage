PImage img;

int res = 1;
int l = 300, a = 150;
char[] ASCII;

int op = 0;
boolean flag = true, simulation = false;

void setup(){
  img = loadImage("bike2.jpg");
  size(736, 626); 
   
   
  background(255);
  fill(0);
  noStroke();
   
  ASCII = new char[256];
  
  String conjunto_caracteres = ".";
  
   for (int i = 0; i < 256; i++) {
    int index = int(map(i, 0, 256, 0, conjunto_caracteres.length()));
    ASCII[i] = conjunto_caracteres.charAt(index);
  }
  
  //transformacao(100, 100, 500, 500);
  //transformacao(0, 0, img.width, img.height);
  
}

void draw(){
  
  //delay(200);
    
    if (keyPressed) {
      if (key == '0') {
        op = 0;
      }
      else if (key == '1') {
        op = 1;
      }
      else if (key == '=') {
        res++;
        flag = true;
      }
      else if (key == '-') {
        if(res - 1 > 0){
          res--;
          flag = true;
        }        
      }    
    }
    
    if(mousePressed){
      simulation = true;
      res = 1;
    }
    
    
    if(simulation){
      res++;
      if(res > 25){
        res = 1;
        simulation = false;
        flag = true;
      }else{
        flag = true;
      }
    }
    
    
    
    if(op == 0 && flag){
      background(255);
      transformacao(0, 0, img.width, img.height);
      flag = false;
    }
    else if(op == 1){
      flag = true;
       //background(255);
       image(img, 0, 0);
       rectMode(CENTER);
       fill(255);
       rect(mouseX, mouseY, l, l);
       int xi = constrain(mouseX - l/2, 0, img.width);
       int yi = constrain(mouseY - l/2, 0, img.height);
       int xf = constrain(mouseX + l/2, 0, img.width);
       int yf = constrain(mouseY + l/2, 0, img.height);
        
        transformacao(xi, yi, xf, yf);
    }
      
}

void transformacao(int xi, int yi, int xf, int yf){
  //img.filter(GRAY);
  img.loadPixels();
 
  for (int y = yi; y < yf; y += res) {
    for (int x = xi; x < xf; x += res) {
      color pixel = img.pixels[y * img.width + x];
      fill(red(pixel), green(pixel), blue(pixel));
      text(ASCII[int(brightness(pixel))], x, y);
    }
  }

}