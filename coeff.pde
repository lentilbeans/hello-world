float coeff(float[] xVals, float[] yVals, String func, int freq) {
  float val = 0;
  int n = xVals.length-1;
  if(freq == 0) {
    for(int k = 0; k<n; k++) {
      val += yVals[k]+yVals[k+1];
    }
    return val/n/2.0;
  } else if(func.equals("sin")) {
    for(int k = 0; k<n; k++) {
      val += yVals[k]*sin(freq*2.0*PI/height*X[k])+yVals[k+1]*sin(freq*2.0*PI/height*X[k+1]);
    }
    return val/n;
  } else if(func.equals("cos")) {
    for(int k = 0; k<n; k++) {
      val += yVals[k]*cos(freq*2.0*PI/height*X[k])+yVals[k+1]*cos(freq*2.0*PI/height*X[k+1]);
    }
    return val/n;
  } else {
    
    return 0;
  }
}

void setCoeff(float[] a, float[] b, float[] xVals, float[] yVals) {
  a[0] = coeff(xVals, yVals, " ", 0);
  b[0] = 0;
  for(int i = 1; i < a.length; i++) {
    a[i] = coeff(xVals, yVals, "cos", i);
    b[i] = coeff(xVals, yVals, "sin", i);
  }
}
