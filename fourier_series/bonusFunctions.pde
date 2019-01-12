//FOURIER SUM CALCULATION
float FourierS(float t, int n) {
  float y = A[0];
  for (int j = 1; j < n; j++) {
    y += A[j]*cos(2.0*PI/height*j*t)+B[j]*sin(2.0*PI/height*j*t);
  }
  return y;
}
//SKETCHING OF CURVE
void sketching() {
  t=0;
  on = false;
  int iNow = findXi(polarMode);
  if(!polarMode) {
    Y[iNow] = height/2-mouseY;
  } else {
    Y[iNow] = dist(mouseX,mouseY,height/2,height/2);
  }
  for (int i = nInt+iNow-nInt/100; i<nInt+iNow+nInt/100+1; i++) {
    Y[i%nInt] = (Y[i%nInt]+5*Y[iNow])/6;
  }
  for (int i = nInt+iNow-nInt/50; i<nInt+iNow+nInt/50+1; i++) {
    Y[i%nInt] = (10*Y[i%nInt]+Y[(i-1)%nInt]+Y[(i+1)%nInt])/12;
  }
  setCoeff(A, B, X, Y);
  for (int i = 0; i<nInt; i++) {
    FS[i] = FourierS(X[i], nNow);
  }
}
//ROUNDING/NORMALIZE
float normalize(float x) {
  return int(10000*x*2.0/3/width)/1000.0;
}
//FINDING PROPER INDEX
int findXi(boolean polar) {
  if(!polar) {
    for (int j = 0; j<nInt; j++) {
      if (mouseX<X[(j+1)%nInt] && mouseX>=X[j]) {
        return j;
      }
    }
  } else {
    float mouseAngle = (atan2(mouseX-height/2,mouseY-height/2)+3*PI/2)%(2*PI);
    for (int j = 0; j<nInt; j++) {
      float angle1 = map(X[j%nInt], X[0], X[nInt-1], 0, 2*PI);
      float angle2 = map(X[(j+1)%nInt], X[0], X[nInt-1], 0, 2*PI);
      if (mouseAngle < angle2 && mouseAngle >= angle1) {
        return j;
      }
    }
  }
  return 0;
}
//DASH (Creates Mark Next To Significant Values)
String dash(float x) {
  if(sq(normalize(x))>0.0009 && showSignif) {
    return "<-";
  }
  return "";
}
