void keyPressed() {
  //START/STOP MVMT
  if(key == ' ') {
    t=0;
    on = !on;
  }
  //ERASE
  if(key == 'e') {
    for(int i = 0; i<nInt; i++) {
      Y[i] = 0;
    }
    setCoeff(A,B,X,Y);
    for(int i = 0; i<nInt; i++) {
      FS[i] = FourierS(X[i],nNow);
    }
  }
  //COPY c, PASTE v
  if(key == 'c') {
    for(int i = 0; i<nInt; i++) {
      Ycopy[i] = Y[i];
    }
  }
  if(key == 'v') {
    for(int i = 0; i<nInt; i++) {
      Y[i] = Ycopy[i];
    }
    setCoeff(A,B,X,Y);
    for(int i = 0; i<nInt; i++) {
      FS[i] = FourierS(X[i],nNow);
    }
  }
  //HUE
  if(key == 'h') {
    HUE = random(1);
    //HUE = (HUE+0.001)%1;
  }
  //SAWTOOTH
  if(key == 'w') {
    for(int i = 0; i<nInt; i++) {
      Y[i] = (1.5*(X[i]+height/2))%(height/2)-height/4;
    }
    setCoeff(A,B,X,Y);
    for(int i = 0; i<nInt; i++) {
      FS[i] = FourierS(X[i],nNow);
    }
  }
  //TRIANGLE
  if(key == 't') {
    for(int i = 0; i<nInt; i++) {
      Y[i] = abs((2*X[i])%(height)-height/2)-height/4;
    }
    setCoeff(A,B,X,Y);
    for(int i = 0; i<nInt; i++) {
      FS[i] = FourierS(X[i],nNow);
    }
  }
  //SQUARE
  if(key == 'q') {
    for(int i = 0; i<nInt; i++) {
      Y[i] = nInt/4000.0*height*(X[(2*i+nInt/2)%nInt]%(height/2)-X[(2*i)%nInt]%(height/2));
    }
    setCoeff(A,B,X,Y);
    for(int i = 0; i<nInt; i++) {
      FS[i] = FourierS(X[i],nNow);
    }
  }
  //RANDOM
  if(key == 'r') {
    Y[0] = 0;
    for(int i = 1; i<nInt; i++) {
      Y[i] = random(-10,10)*height*1.0/nInt+Y[i-1];
    }
    for(int i = nInt; i<6*nInt; i++) {
      Y[i%nInt] = (Y[i%nInt]+Y[(i-1)%nInt])/2;
    }
    setCoeff(A,B,X,Y);
    for(int i = 0; i<nInt; i++) {
      FS[i] = FourierS(X[i],nNow);
    }
  }
  //SMOOTH
  if(key == 's') {
    for(int i = nInt; i<40*nInt; i++) {
      Y[i%nInt] = (Y[i%nInt]+Y[(i-1)%nInt]+Y[(i+1)%nInt])/3;
    }
    setCoeff(A,B,X,Y);
    for(int i = 0; i<nInt; i++) {
      FS[i] = FourierS(X[i],nNow);
    }
  }
  //ARROWS
  if(key == 'a') {
    showSignif = !showSignif;
  }
  //POLAR MODE
  if(key == 'p') {
    polarMode = !polarMode;
  }
  if(keyCode==DOWN) {
    nNow = max(nNow-1,1);
    for(int i = 0; i<nInt; i++) {
      FS[i] = FourierS(X[i],nNow);
    }
  }
  if(keyCode==UP) {
    nNow = min(nNow + 1,nApprox+1);
    for(int i = 0; i<nInt; i++) {
      FS[i] = FourierS(X[i],nNow);
    }
  }
  //SHIFT
  if(keyCode==SHIFT) {
    if(shft == nInt/10) {
      shft = 1;
      shftSpd = "SLOW";
    } else if(shft == 1) {
      shft = nInt/100; 
      shftSpd = "MEDIUM";
    } else {
      shft = nInt/10; 
      shftSpd = "FAST";
    }
  }
  if(keyCode==LEFT) {
    for(int i = 0; i<nInt; i++) {
      Yshift[i] = Y[(i+shft)%nInt];
    }
    for(int i = 0; i<nInt; i++) {
      Y[i] = Yshift[i];
    }
    setCoeff(A,B,X,Y);
    for(int i = 0; i<nInt; i++) {
      FS[i] = FourierS(X[i],nNow);
    }
    display();
  }
  if(keyCode==RIGHT) {
    for(int i = 0; i<nInt; i++) {
      Yshift[i] = Y[(i+nInt-shft)%nInt];
    }
    for(int i = 0; i<nInt; i++) {
      Y[i] = Yshift[i];
    }
    setCoeff(A,B,X,Y);
    for(int i = 0; i<nInt; i++) {
      FS[i] = FourierS(X[i],nNow);
    }
    display();
  }
}

void mousePressed() {
  mPressed = true;
}
void mouseReleased() {
  mPressed = false;
}
