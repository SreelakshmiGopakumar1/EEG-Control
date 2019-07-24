%reading a data
filename = 'E:\my pro\baba (15).CSV';

range='C2:C5000'
X1=xlsread(filename,range)
X1=X1-mean(X1)
   [b,a]=butter(8,.1,'high')
   Y1=filter(b,a,X1)    %X1 filtered n smoothened
   Y1=smooth(Y1,13)


range='D2:D5000'
X2=xlsread(filename,range)
X2=X2-mean(X2)
  [b,a]=butter(8,.1,'high')
   Y2=filter(b,a,X2)    %X2 filtered n smoothened
   Y2=smooth(Y2,13)
   
   
   
   range='E2:E5000'
X3=xlsread(filename,range)
X3=X3-mean(X3);
   [b,a]=butter(8,.1,'high')
   Y3=filter(b,a,X3)     %X3 filtered n smoothened
   Y3=smooth(Y3,13)
   
   
   range='F2:F5000'
X4=xlsread(filename,range)
X4=X4-mean(X4)
  [b,a]=butter(8,.1,'high')
   Y4=filter(b,a,X4)    %X4 filtered n smoothened
   Y4=smooth(Y4,13)
   
   
range='G2:G5000'
X5=xlsread(filename,range)
X5=X5-mean(X5)
  [b,a]=butter(8,.1,'high')
   Y5=filter(b,a,X5)    %X5 filtered n smoothened
   Y5=smooth(Y5,13)
   
   range='H2:H5000'
X6=xlsread(filename,range)
X6=X6-mean(X6)
  [b,a]=butter(8,.1,'high')
   Y6=filter(b,a,X6)    %X6 filtered n smoothened
   Y6=smooth(Y6,13)
   
   range='I2:I5000'
X7=xlsread(filename,range)
X7=X7-mean(X7)
  [b,a]=butter(8,.1,'high')
   Y7=filter(b,a,X7)    %X7 filtered n smoothened
   Y7=smooth(Y7,13)
   
   range='J2:J5000'
X8=xlsread(filename,range)
X8=X8-mean(X8)
  [b,a]=butter(8,.1,'high')
   Y8=filter(b,a,X8)    %X8 filtered n smoothened
   Y8=smooth(Y8,13)
   
   range='K2:K5000'
X9=xlsread(filename,range)
X9=X9-mean(X9)
  [b,a]=butter(8,.1,'high')
   Y9=filter(b,a,X9)    %X9 filtered n smoothened
   Y9=smooth(Y9,13)
   
   
   range='L2:L5000'
X10=xlsread(filename,range)
X10=X10-mean(X10)
  [b,a]=butter(8,.1,'high')
   Y10=filter(b,a,X10)    %X10 filtered n smoothened
   Y10=smooth(Y10,13)
   
   range='M2:M5000';
X11=xlsread(filename,range)
X11=X11-mean(X11);
   [b,a]=butter(8,.1,'high')
   Y11=filter(b,a,X11)     %X11 filtered n smoothened
   Y11=smooth(Y11,13)

range='N2:N5000';
X12=xlsread(filename,range)
X12=X12-mean(X12);
   [b,a]=butter(8,.1,'high')
   Y12=filter(b,a,X12)     %X12 filtered n smoothened
   Y12=smooth(Y12,13)

range='O2:O5000';
X13=xlsread(filename,range)
X13=X13-mean(X13);
   [b,a]=butter(8,.1,'high')
   Y13=filter(b,a,X13)   %X13 filtered n smoothened
   Y13=smooth(Y13,13)

range='P2:P5000';
X14=xlsread(filename,range)
X14=X14-mean(X14)
   [b,a]=butter(8,.1,'high')
   Y14=filter(b,a,X14)     %X14 filtered n smoothened
   Y14=smooth(Y14,13)


figure (1)         % input signals
subplot 331
plot(X1)
subplot 332
plot(X2)
subplot 333
plot(X3)
subplot 334
plot(X4)
subplot 335
plot(X5)
subplot 336
plot(X6)
subplot 337
plot(X7)



figure (2) %input signals

subplot 331
plot(X8)
subplot 332
plot(X9)
subplot 333
plot(X10)
subplot 334
plot(X11)
subplot 335
plot(X12)
subplot 336
plot(X13)
subplot 337
plot(X14)



