PImage miImagen;

void setup(){
  size(800,400);
  miImagen = loadImage("mural geometrico.jpg");
}

void draw(){
  background(240,240,240);
  
  //circulos
  fill(15,60,141);
  ellipse(600,200,700,700);
  fill(176,196,232);
  ellipse(600,200,510,510);
  fill(15,60,141);
  ellipse(600,200,470,470);
  fill(176,196,232);
  ellipse(600,200,430,430);
  fill(15,60,141);
  ellipse(600,200,390,390);
  fill(176,196,232);
  ellipse(600,200,350,350);
  fill(15,60,141);
  ellipse(600,200,310,320);
  fill(176,196,232);
  ellipse(600,200,270,270);
  fill(15,60,141);
  ellipse(600,200,230,230);
  fill(176,196,232);
  ellipse(600,200,190,190);
  fill(15,60,141);
  ellipse(600,200,150,150);
  fill(176,196,232);
  ellipse(600,200,110,110);
  fill(15,60,141);
  ellipse(600,200,70,70);
  
  //lineas rojas
  push();
    strokeWeight(15);
    stroke(151,41,57);
    line(408,0,600,193);
    line(791,0,600,193);
    line(408,400,600,208);
    line(791,400,600,208);
  triangle(197,199,63,66,66,335);
  pop();
  
  //triangulo blanco
  fill(193,203,226);
  triangle(600,200,400,0,400,400);
  triangle(600,200,800,0,800,400);
  
  //lines triangulo blanco
  line(406,7,406,394);
  line(412,13,412,386);
  line(418,19,418,381);
  line(424,24,424,375);
  line(430,30,430,369);
  line(436,36,436,363);
  line(442,42,442,357);
  line(448,48,448,351);
  line(454,54,454,345);
  
  line(739,61,739,339);
  line(745,55,745,345);
  line(751,49,751,351);
  line(757,43,757,357);
  line(763,37,763,363);
  line(769,31,769,369);
  line(775,25,775,375);
  line(781,19,781,381);
  line(787,13,787,387);
  line(793,7,793,393);
  
  //lineas verdes
  fill(117,158,66);
  triangle(600,200,456,56,456,343);
  triangle(600,200,739,60,739,338);
  
  //trianguoo verde agua
  fill(101,192,178);
  triangle(600,200,577,177,577,222);
  triangle(600,200,624,175,624,223);
  
  rect(470,121,51,157);
  rect(680,120,45,160);

  
  //trapecio rojo
  beginShape();
    fill(144,32,62);
    vertex(577,177);
    vertex(577,223);
    vertex(535,265);
    vertex(535,135);
  endShape();
  beginShape();
    fill(144,32,62);
    vertex(624,223);
    vertex(624,175);
    vertex(666,134);
    vertex(666,266);
  endShape();
  
  //triangulos naranjas
  fill(199,87,46);
  triangle(470,330,521,279,470,278);
  triangle(521,121,470,70,470,121);
  triangle(680,120,725,73,725,120);
  triangle(680,280,725,324,725,280);
  
  triangle(521,121,470,160,521,199);
  triangle(521,199,470,238,521,278);
  triangle(680,120,725,160,680,199);
  triangle(680,199,725,238,680,280);
  
  
  
  image(miImagen,0,0,400,400);
 
  
  
  push(); 
    fill(0,0,0);
    textSize(15);
    text(mouseX + " - " + mouseY, mouseX, mouseY);
    //text((mouseX + 400) + " - " + mouseY, mouseX, mouseY);
  pop();
}
