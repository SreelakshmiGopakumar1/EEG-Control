filename = 'C:\Users\USER\Desktop\eeg_movements\pms4.CSV';

range='C2:C5000'
X1=xlsread(filename,range);
subplot(4,4,1)
plot(X1)

range='D2:D5000'
X2=xlsread(filename,range);
subplot(4,4,2)
plot(X2)

range='E2:E5000'
X3=xlsread(filename,range);
subplot(4,4,3)
plot(X3)

range='M2:M5000'
X4=xlsread(filename,range);
subplot(4,4,4)
plot(X4)

range='N2:N5000'
X5=xlsread(filename,range);
subplot(4,4,5)
plot(X5)

range='O2:O5000'
X6=xlsread(filename,range);
subplot(4,4,6)
plot(X6)

range='P2:P5000'
X7=xlsread(filename,range);
subplot(4,4,7)
plot(X7)


X=[X1 X2 X3 X4 X5 X6 X7];

[a,b]=butter(8,.1,'high')      %filtered the input
y=filter(b,a,X)
subplot(4,4,8)
plot(y)
 
S=smooth(X,13)                 %smoothed the filtered output
subplot(4,4,9)
plot(S)

[COEFF SCORE]= pca(X)          %correlated into uncorrelated

y1=(SCORE(:,1))
figure 
subplot(3,3,1)
plot(y1)

d1=smooth(y1,13)
subplot(3,3,4)
plot(d1)
 
y2=(SCORE(:,4))
subplot(3,3,2)
plot(y2)

d2=smooth(y2,13)
subplot(3,3,5)
plot(d2)

y3=(SCORE(:,6))
subplot(3,3,3)
plot(y3)

d3=smooth(y3,13)
subplot(3,3,6)
plot(d3)

d=[d1 d2 d3];
figure                           %threshold finding
findpeaks(d1,128,'MinPeakHeight',165)


% [pks,locs]=findpeaks(d,'minpeakheight',165,'minpeakdistance',24,'npeaks',5)

% x1 = ones(1,5);
% for n = 2:6
%    
% end
% figure
% plot(x1)



% x=d1; y=fft(x); 
% PS=abs(y).^2;
% N=length(x); 
% fs=128; 
% freq=(1:N/2)*fs/N; 
% 
% plot(freq,PS)


% for k=1:5
% subsig(k,:)=pks( 1+(k-1)*8*20 : k*8*20 )
% end






