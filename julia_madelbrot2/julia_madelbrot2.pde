/* 
  Julia & Mandelbrot Sets
  by Lenti @lentilbeans
  
  press c to stop/play hue change
  press x to freeze/unfreeze x position of mouse
  press y to freeze/unfreeze y position of 
  
  BASE CODE FROM @schiffman
 */

float t = 0;
float mouX = 0;
float mouY = 0;

boolean freezeX = false, freezeY = false, freezeColor = false;

void setup() {
  size(1600, 800);
  colorMode(HSB, 1);
}

void draw() {
  if(!freezeX && !freezeY) {
    mouX = mouseX;
    mouY = mouseY;
  } else if(!freezeX) {
    mouX = mouseX;
  } else if(!freezeY) {
    mouY = mouseY;
  }
  if(!freezeColor) {
    t = (t+0.001)%1;
  }
  
  float w = 5.0;
  float h = w*height/(width/2);
  
  float x_MIN = -w/2;
  float y_MIN = -h/2;
  
  int MAX_iterations = 100;
  
  //JULIA//
  
  background(255);
  
  float ca = map(mouX % (width/2), 0, (width/2), -w/2, w/2);
  float cb = map(mouY, 0, height, -h/2, h/2);
  
  loadPixels();
  
  float dx = w / (width/2);
  float dy = h / height;
  
  float y = y_MIN;
  for(int j = 0; j < height; j++) {
    float x = x_MIN;
    for(int i = 0; i < (width/2); i++) {
      float a = x;
      float b = y;
      int n = 0;
      while(n < MAX_iterations) {
        float aa = a*a;
        float bb = b*b;
        float ab2 = 2.0*a*b;
        if(aa + bb > 9.0) {
          break;
        }
        a = aa - bb + ca;
        b = ab2 + cb;
        n++;
      }
      if(n == MAX_iterations) {
        pixels[i+j*width] = color(0);
      } else {
        float hue = sqrt(float(n)/MAX_iterations);
        pixels[i+j*width] = color(t, 1, sqrt(hue));
      }
        
      x += dx;
    }
    y += dy;
  }
  updatePixels();

  //MANDELBROT//

  fill(0);
  noStroke();
  rect(width/2,0,width/2,height);
  
  loadPixels();
  
  float dxx = w / (width/2);
  float dyy = h / (height);
  
  float yy = y_MIN;
  for(int j = 0; j < height; j++) {
    float xx = x_MIN;
    for(int i = width/2; i < width; i++) {
      float c = xx;
      float d = yy;
      int nn = 0;
      while(nn < MAX_iterations) {
        float cc = c*c;
        float dd = d*d;
        float cd2 = 2.0*c*d;
        if(cc + dd > 4.0) {
          break;
        }
        c = cc - dd + xx;
        d = cd2 + yy;
        nn++;
      }
      if(nn == MAX_iterations) {
        pixels[i+j*width] = color(0);
      } else {
        float hue = sqrt(float(nn)/MAX_iterations);
        pixels[i+j*width] = color(0, 0, hue);
      }
      xx += dxx;
    }
    yy += dyy;
  }
  updatePixels();
  
  stroke(1);
  strokeWeight(1);
  float mx = width/2+(mouX % (width/2));
  float my = mouY;
  float k = map(0.01, 0, 1, 0, (width/2)); //cursor radius is 1st input as % of whole mandelbrot canvas
  line(mx-k,my,mx+k,my);
  line(mx,my-k,mx,my+k);
}

void keyReleased() {
  if(key == 'x') {
    freezeX = !freezeX;
  }
  if(key == 'y') {
    freezeY = !freezeY;
  }
  if(key == 'c') {
    freezeColor = !freezeColor;
  }
}