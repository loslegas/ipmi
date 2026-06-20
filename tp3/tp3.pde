// VIDEO: https://youtu.be/LINK_AQUI

PImage referenciaImg;

float tamañoMax = 50;
float tamañoMin = 2;
boolean invertido = false;
boolean congelado = false;  // NUEVO: controla si los círculos reaparecen o no

color colorFondo;
color colorCirculo;

int maxCirculosOcultos = 500;
float[] ocultosX = new float[maxCirculosOcultos];
float[] ocultosY = new float[maxCirculosOcultos];
int[] ocultosTime = new int[maxCirculosOcultos];
int cantOcultos = 0;

void setup() {
  size(800, 400);
  referenciaImg = loadImage("circulos.jpg");
  for (int i = 0; i < maxCirculosOcultos; i++) {
    ocultosTime[i] = 0;
  }
}

void draw() {
  if (invertido) {
    colorFondo = color(0);
    colorCirculo = color(255);
  } else {
    colorFondo = color(255);
    colorCirculo = color(0);
  }

  background(colorFondo);
  dibujarImagen();

  stroke(150);
  strokeWeight(2);
  line(400, 0, 400, height);

  dibujarPatron();
}

void dibujarImagen() {
  image(referenciaImg, 0, 0, 400, 400);
}

void dibujarPatron() {
  int filas = 18;

  for (int fila = 0; fila < filas; fila++) {
    float diametro = calcularDiametro(fila, filas);
    float espaciado = diametro * 1.6;
    int cantidad = calcularCantidad(espaciado);

    float anchoFila = cantidad * espaciado;
    float offsetX = (400 - anchoFila) / 2;

    for (int col = 0; col < cantidad; col++) {
      float x = 400 + offsetX + espaciado * col + espaciado / 2;
      float y = map(fila, 0, filas - 1, diametro, height - diametro);
      dibujarCirculo(x, y, diametro);
    }
  }
}

float calcularDiametro(int fila, int totalFilas) {
  return map(fila, 0, totalFilas - 1, tamañoMin, tamañoMax);
}

int calcularCantidad(float espaciado) {
  return int(400 / espaciado);
}

boolean estaOculto(float x, float y) {
  for (int i = 0; i < cantOcultos; i++) {
    if (abs(ocultosX[i] - x) < 1 && abs(ocultosY[i] - y) < 1) {
      // MODIFICADO: si está congelado, siempre oculto; si no, solo 2 segundos
      if (congelado || millis() - ocultosTime[i] < 2000) {
        return true;
      }
    }
  }
  return false;
}

void dibujarCirculo(float x, float y, float diametro) {
  if (estaOculto(x, y)) {
    return;
  }

  float distancia = dist(mouseX, mouseY, x, y);

  if (mouseX > 400 && distancia < diametro / 2) {
    registrarOculto(x, y);
    return;
  }

  float variacion = random(-10, 10);
  if (invertido) {
    fill(255 + variacion);
  } else {
    fill(0 + variacion);
  }

  noStroke();

  pushMatrix();
  translate(x, y);
  rotate(radians(map(x, 400, 800, 0, 15)));
  ellipse(0, 0, diametro, diametro);
  popMatrix();
}

void registrarOculto(float x, float y) {
  for (int i = 0; i < cantOcultos; i++) {
    if (abs(ocultosX[i] - x) < 1 && abs(ocultosY[i] - y) < 1) {
      ocultosTime[i] = millis();
      return;
    }
  }
  if (cantOcultos < maxCirculosOcultos) {
    ocultosX[cantOcultos] = x;
    ocultosY[cantOcultos] = y;
    ocultosTime[cantOcultos] = millis();
    cantOcultos++;
  }
}

// EVENTO DE MOUSE: click para congelar/descongelar el patrón
void mousePressed() {
  if (mouseX > 400) {
    congelado = !congelado;
  }
}

void keyPressed() {
  if (key == ' ') {
    invertido = !invertido;
  }
  if (key == 'r' || key == 'R') {
    reiniciar();
  }
}

void reiniciar() {
  invertido = false;
  congelado = false;
  cantOcultos = 0;
  for (int i = 0; i < maxCirculosOcultos; i++) {
    ocultosTime[i] = 0;
  }
}
