int nInt = 1000, nApprox = 100, nNow = min(nApprox, 50)+1, shft = 1;
float t = 0, HUE = 5.0/6;
boolean on = false, mPressed = false, polarMode = false, showSignif = false;
String shftSpd = "SLOW";
float[] X = new float[nInt], Y = new float[nInt], 
  FS = new float[nInt], 
  Ycopy = new float[nInt], Yshift = new float[nInt],
  A = new float[nApprox+1], B = new float[nApprox+1];

void setup() {
  size(2800, 1800);
  //fullScreen();
  colorMode(HSB,1);
  background(0);
  for (int i = 0; i<nInt; i++) {
    X[i] = i*height*1.0/(nInt-1);
  }
  setCoeff(A, B, X, Y);
  for (int i = 0; i<nInt; i++) {
    FS[i] = FourierS(X[i], nApprox);
  }
}

void display() {
  backdrop1(polarMode);

  stroke(1);
  strokeWeight(1/1800.0*height);
  plot(X, Y, polarMode);

  stroke(HUE, 1, 1);
  strokeWeight(2/1800.0*height);
  plot(X, FS, polarMode);

  if (on) {
    t+=nInt/250.0;
  }

  backdrop2();
}

void draw() {
  display();

  if (mPressed) {
    sketching();
  }
}

////DISPLAY////

void plot(float[] IN, float[] OUT, boolean polar) {
  int N = IN.length;
  if (!polar) {
    for (int i = 0; i<N-1; i++) {
      line(IN[i], height/2-OUT[int(i+t)%N], IN[(i+1)], height/2-OUT[int(i+t+1)%N]);
    }
  } else {
    float angleA = 0, angleB = 0;
    for (int i = 0; i<N; i++) {
      angleA = map(IN[i%N], IN[0], IN[N-1], 0, 2*PI);
      angleB = map(IN[(i+1)%N], IN[0], IN[N-1], 0, 2*PI);
      line(height/2+OUT[int(i+t)%N]*cos(angleA), height/2-OUT[int(i+t)%N]*sin(angleA), 
        height/2+OUT[int(i+t+1)%N]*cos(angleB), height/2-OUT[int(i+t+1)%N]*sin(angleB));
    }
  }
}

void backdrop1(boolean polar) {
  int n = 4;
  background(0);
  noFill();
  stroke(10.0/51);
  strokeWeight(3/1800.0*height);
  if (!polar) {
    for (int i = -n; i<n+1; i++) {
      line(0, height/2+i*height/2.0/n, height, height/2+i*height/2.0/n);
      line((i+n)*height/2.0/n, 0, (i+n)*height/2.0/n, height);
    }
  } else {
    for (int i = 0; i<1.5*n; i++) {
      line(height/2-height*cos(PI/n*i), height/2+height*sin(PI/n*i), 
        height/2+height*cos(PI/n*i), height/2-height*sin(PI/n*i));
      ellipse(height/2, height/2, (i+1)*height/n, (i+1)*height/n);
    }
  }
}

void backdrop2() {
  noStroke();
  fill(0.8);
  rect(height, 0, width-height, height);
  textDisplay();  
  stroke(10.0/51);
  strokeWeight(20/1800.0*height);
  noFill();
  rect(-20, 0, width+50, height);
}

void textDisplay() {
  float h = height;
  textSize(40/1800.0*height);
  fill(0);
  text("f(x) = a_0+"+char(931)+" a_n"+char(183)+"cos(nx)+b_n"+char(183)+"sin(nx)", h+20/1800.0*height, 70/1800.0*height);
  textSize(20/1800.0*height);
  text("Fourier Sum to N = "+(nNow-1), h+10/1800.0*height, 100/1800.0*height);
  String strA = "a_0 = "+normalize(A[0])+"\n", strB = "";
  for (int i = 1; i<nNow; i++) {
    strA+="a_"+i+" = "+normalize(A[i])+"    "+dash(A[i])+"\n";
    strB+="b_"+i+" = "+normalize(B[i])+"    "+dash(B[i])+"\n";
  }
  text(strA, h+50/1800.0*height, 150/1800.0*height);
  text(strB, h+300/1800.0*height, 180/1800.0*height);
  String strControls = "UP   - Increase N\n"+
    "DOWN - Decrease N\n"+
    "LEFT - Shift Left\n"+
    "RIGHT - Shift Right\n"+
    "SHIFT - Shift Speed: "+shftSpd+"\n"+
    "C    - Copy Curve\n"+
    "V    - Paste Curve\n"+
    "E    - Erase Curve\n"+
    "A    - Arrows (On/Off)\n"+
    "R    - Random Curve\n"+
    "P    - Polar Mode\n"+
    "S    - Smoothen\n"+
    "H    - Change Hue\n"+
    "sQuare wave\n"+
    "saWtooth wave\n"+
    "Triangle wave\n"+
    "SPACE - Play/Stop\n"+
    "\n";
  text(strControls, width-300/1800.0*height, 150/1800.0*height);
}
