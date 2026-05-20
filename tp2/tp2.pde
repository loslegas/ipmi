PImage[] imagenes = new PImage[5];
PFont fuente;

int pantallaActual = 0;
int totalPantallas = 5;
boolean enInicio = true;
boolean enFinal = false;

float alpha = 0;
float velocidadFade = 3;
float textY;
float textYDestino = 200;

float imgX;
float imgXDestino = 30;

boolean infoVisible = false;
float alphaInfo = 0;
boolean infoApareciendo = false;
boolean infoDesapareciendo = false;

int tiempoUltimoCambio = 0;
int duracionPantalla = 6000;

String[] nombresBandas = {
  "Michael Jackson",
  "AC/DC",
  "Red Hot Chili Peppers",
  "Radiohead",
  "Linkin Park"
};

String[] generoBandas = {
  "Pop / R&B / Soul",
  "Hard Rock / Heavy Metal",
  "Rock Alternativo / Funk Rock",
  "Rock Experimental / Art Rock",
  "Rock Alternativo / Nu Metal"
};

String[] anioBandas = {
  "Carrera solista desde 1971",
  "Formados en Sydney, 1973",
  "Formados en Los Angeles, 1983",
  "Formados en Oxford, 1985",
  "Formados en California, 1996"
};

String[] albumBandas = {
  "Album icónico: Thriller (1982)",
  "Album icónico: Back in Black (1980)",
  "Album icónico: Californication (1999)",
  "Album icónico: OK Computer (1997)",
  "Album icónico: Hybrid Theory (2000)"
};

void setup() {
  size(640, 480);
  fuente = loadFont("Arial-BoldItalicMT-48.vlw");
  imagenes[0] = loadImage("mj.jpg");
  imagenes[1] = loadImage("acdc.jpg");
  imagenes[2] = loadImage("rhcp.jpg");
  imagenes[3] = loadImage("radiohead.jpg");
  imagenes[4] = loadImage("linkinpark.jpg");
  resetearAnimacion();
}

void draw() {
  if (enInicio) {
    mostrarPantallaInicio();
  } else if (enFinal) {
    mostrarPantallaFinal();
  } else {
    mostrarBanda(pantallaActual);
    animarElementos();
    controlarTiempo();
  }
}

void mostrarPantallaInicio() {
  background(0);
  dibujarBoton("INICIAR", width/2, height/2, 180, 50, color(220, 50, 50));
}

void mostrarBanda(int indice) {
  background(20);

  if (imagenes[indice] != null) {
    float imgW = 280;
    float imgH = 380;
    float imgY = (height - imgH) / 2;
    fill(0, 0, 0, 100);
    noStroke();
    rect(imgX + 8, imgY + 8, imgW, imgH);
    image(imagenes[indice], imgX, imgY, imgW, imgH);
    noFill();
    stroke(255, 255, 255, 180);
    strokeWeight(2);
    rect(imgX, imgY, imgW, imgH);
    noStroke();
  }

  stroke(220, 50, 50, alpha);
  strokeWeight(3);
  line(320, 60, 320, height - 60);
  noStroke();

  fill(220, 50, 50, alpha);
  textFont(fuente, 16);
  textAlign(LEFT, TOP);
  text("0" + (indice + 1) + " / 0" + totalPantallas, 340, textY - 120);

  int tamañoNombre;
  if (nombresBandas[indice].length() > 15) {
    tamañoNombre = 24;
  } else {
    tamañoNombre = 34;
  }

  textFont(fuente, tamañoNombre);
  float nombreY = textY - 80;
  boolean hoverNombre = (mouseX > 340 && mouseX < 630 &&
                         mouseY > nombreY && mouseY < nombreY + tamañoNombre + 10);

  if (hoverNombre) {
    fill(255, 200, 50, alpha);
  } else {
    fill(255, 255, 255, alpha);
  }

  textAlign(LEFT, TOP);
  text(nombresBandas[indice], 340, nombreY);

  textFont(fuente, 12);
  fill(180, 180, 180, alpha);
  text("(toca para más info)", 340, nombreY + tamañoNombre + 5);

  if (infoVisible || infoApareciendo || infoDesapareciendo) {
    float infoY = textY - 10;
    fill(0, 0, 0, alphaInfo * 0.6);
    noStroke();
    rect(335, infoY - 5, 290, 110, 5);
    fill(220, 50, 50, alphaInfo);
    textFont(fuente, 15);
    textAlign(LEFT, TOP);
    text(generoBandas[indice], 340, infoY);
    fill(200, 200, 200, alphaInfo);
    textFont(fuente, 14);
    text(anioBandas[indice], 340, infoY + 30);
    fill(200, 200, 200, alphaInfo);
    text(albumBandas[indice], 340, infoY + 60);
  }

  dibujarBarraProgreso();
}

void controlarTiempo() {
  int tiempoTranscurrido = millis() - tiempoUltimoCambio;

  if (tiempoTranscurrido >= duracionPantalla && pantallaActual < totalPantallas - 1) {
    pantallaActual++;
    resetearAnimacion();
  } else if (tiempoTranscurrido >= duracionPantalla && pantallaActual == totalPantallas - 1) {
    enFinal = true;
  }
}

void animarElementos() {
  if (alpha < 255) {
    alpha += velocidadFade;
  }
  textY = lerp(textY, textYDestino, 0.05);
  imgX = lerp(imgX, imgXDestino, 0.07);

  if (infoApareciendo) {
    alphaInfo += 5;
    if (alphaInfo >= 255) {
      alphaInfo = 255;
      infoApareciendo = false;
      infoVisible = true;
    }
  }

  if (infoDesapareciendo) {
    alphaInfo -= 5;
    if (alphaInfo <= 0) {
      alphaInfo = 0;
      infoDesapareciendo = false;
      infoVisible = false;
    }
  }
}

void dibujarBarraProgreso() {
  float progreso = float(millis() - tiempoUltimoCambio) / duracionPantalla;
  fill(60);
  noStroke();
  rect(0, height - 8, width, 8);
  fill(220, 50, 50);
  rect(0, height - 8, width * progreso, 8);
}

void resetearAnimacion() {
  alpha = 0;
  textY = height + 50;
  imgX = -300;
  infoVisible = false;
  infoApareciendo = false;
  infoDesapareciendo = false;
  alphaInfo = 0;
  tiempoUltimoCambio = millis();
}

void mostrarPantallaFinal() {
  background(0);
  dibujarBoton("REINICIAR", width/2, height/2, 200, 55, color(220, 50, 50));
}

void dibujarBoton(String etiqueta, float x, float y, float w, float h, color colorBoton) {
  boolean mouseEncima = (mouseX > x - w/2 && mouseX < x + w/2 &&
                         mouseY > y - h/2 && mouseY < y + h/2);
  if (mouseEncima) {
    fill(red(colorBoton) + 40, green(colorBoton) + 40, blue(colorBoton) + 40);
  } else {
    fill(colorBoton);
  }
  noStroke();
  rect(x - w/2, y - h/2, w, h, 10);
  fill(255);
  textFont(fuente, 22);
  textAlign(CENTER, CENTER);
  text(etiqueta, x, y);
}

void mouseClicked() {
  if (enInicio) {
    boolean enBotonInicio = (mouseX > width/2 - 90 && mouseX < width/2 + 90 &&
                             mouseY > height/2 - 25 && mouseY < height/2 + 25);
    if (enBotonInicio) {
      enInicio = false;
      resetearAnimacion();
    }

} else if (enFinal) {
    boolean enBotonFinal = (mouseX > width/2 - 100 && mouseX < width/2 + 100 &&
                            mouseY > height/2 - 27 && mouseY < height/2 + 27);
    if (enBotonFinal) {
      reiniciar();
    }

  } else {
    int tamañoNombre = (nombresBandas[pantallaActual].length() > 15) ? 24 : 34;
    float nombreY = textYDestino - 80;
    boolean clickEnNombre = (mouseX > 340 && mouseX < 630 &&
                             mouseY > nombreY && mouseY < nombreY + tamañoNombre + 10);
    if (clickEnNombre) {
      if (infoVisible || infoApareciendo) {
        infoApareciendo = false;
        infoDesapareciendo = true;
      } else {
        infoDesapareciendo = false;
        infoApareciendo = true;
      }
    }
  }
}

void reiniciar() {
  pantallaActual = 0;
  enInicio = true;
  enFinal = false;
  resetearAnimacion();
}
