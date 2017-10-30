PImage img;

//resoluçao espacial (espacamento dos caracteres) que sera aplicado o mapeamento dos caracteres
int ESPACAMENTO = 1;
int MAX_ESPACAMENTO = 20;
//dimensao do quadrado que ira envolver o mapeamento parcial 
int l = 300;

char[] ASCII;

int op = 1;
boolean flag = true, simulation = false;

String nome_img = "chopper.jpg";

void setup(){
  img = loadImage(nome_img);
  size(640, 480); 
    
   //tabela ASCII
  ASCII = new char[256];
  
  //Caracteres escolhidos para compor o mapeamento da imagem
  //resultado legal, usando os seguintes caracteres: +-=/ 
  String conjunto_caracteres = "+";
  
  //inicializando o vetor com os caracteres escolhidos
   for (int i = 0; i < 256; i++) {
    int index = int(map(i, 0, 256, 0, conjunto_caracteres.length()));
    ASCII[i] = conjunto_caracteres.charAt(index);
  }
}

void draw(){
    
  if(simulation){
    delay(200);
    ESPACAMENTO--;
    if(ESPACAMENTO < 2){
      ESPACAMENTO = 1;
      simulation = false;
      flag = true;
    }else{
      flag = true;
    }
  }
    
  if(op == 1 && flag){
    background(255);
    transformacao(0, 0, img.width, img.height);
    flag = false;
  }
  else if(op == 2){
     flag = true;
     image(img, 0, 0);
     
     rectMode(CENTER);
     fill(255);
     rect(mouseX, mouseY - 5, l, l);
     
     int xi = constrain(mouseX - l/2, 0, img.width);
     int yi = constrain(mouseY - l/2, 0, img.height);
     int xf = constrain(mouseX + l/2, 0, img.width);
     int yf = constrain(mouseY + l/2, 0, img.height);
     
     transformacao(xi, yi, xf, yf);
  }
      
}

void transformacao(int xi, int yi, int xf, int yf){
  img.loadPixels();
 
  for (int y = yi; y < yf; y += ESPACAMENTO) {
    for (int x = xi; x < xf; x += ESPACAMENTO) {
      color pixel = img.pixels[y * img.width + x];
      fill(red(pixel), green(pixel), blue(pixel));
      text(ASCII[int(brightness(pixel))], x, y);
    }
  }

}

//as CallBacks funcionam somente com a implementaçao do metodo draw
//CallBack responsavel pelo teclado
void keyPressed(){
 if (key == '1') {
    op = 1;
  }
  else if (key == '2') {
    op = 2;
  }
  else if (key == '=') {
    //aumentar o espacamento manualmente
    if(ESPACAMENTO + 1 <= MAX_ESPACAMENTO){
      ESPACAMENTO++;
      flag = true;
    }
  }
  else if (key == '-') {
    //diminuir o espacamento manualmente
    if(ESPACAMENTO - 1 > 0){
      ESPACAMENTO--;
      flag = true;
    }        
  }
  else if(key == 'p' || key == 'P'){
    saveFrame("snapshots//" + nome_img);
  }
}

void mousePressed(){
    //dando inicio a animaçao de mapeamento por caracteres
    simulation = true;
    ESPACAMENTO = 20;
}