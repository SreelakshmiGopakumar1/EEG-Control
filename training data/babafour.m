
%reading a data CSV
filename = 'E:\my pro\baba (14).CSV';

range='C2:C5000'
X1=xlsread(filename,range)
X1=X1-mean(X1)
   [b,a]=butter(8,.1,'high')
   Y1=filter(b,a,X1)    %X1 filtered n smoothened
   Y1=smooth(Y1,13)


 range='E2:E5000'
X3=xlsread(filename,range)
X3=X3-mean(X3)
  [b,a]=butter(8,.1,'high')
   Y3=filter(b,a,X3)    %X3 filtered n smoothened
   Y3=smooth(Y3,13)
   
    
 range='J2:J5000'
X8=xlsread(filename,range)
X8=X8-mean(X8)
  [b,a]=butter(8,.1,'high')
   Y8=filter(b,a,X8)    %X8 filtered n smoothened
   Y8=smooth(Y8,13)
   

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
plot(X3)
subplot 333
plot(X8)
subplot 334
plot(X14)


X=[X1 X3 X8 X14]

[COEFF,SCORE,latent] = princomp(X)

figure (2)                   %outputs from pca
x_pcaout_1=SCORE(:,1)
y1=smooth(x_pcaout_1,13)
fs=128;
t=1/fs:1/fs:length(x_pcaout_1)/fs;
subplot 211
plot(t,x_pcaout_1)
subplot 212
plot(t,y1)

% figure (3)                   %outputs from pca
% x_pcaout_2=SCORE(:,4)
% y2=smooth(x_pcaout_2,13)
% fs=128;
% t=1/fs:1/fs:length(x_pcaout_2)/fs;
% subplot 211
% plot(t,x_pcaout_2)
% subplot 212
% plot(t,y2)


% x_pcaout_2=SCORE(:,4)
% subplot 212
% plot(x_pcaout_2)
% 
% x_pcaout_3=SCORE(:,6)
% subplot 213
% plot(x_pcaout_3)

figure (4)

subplot 511
plot(x_pcaout_1)

subplot 512
y_pcaout_1=zeros(1,length(x_pcaout_1))

for ii=1:length(x_pcaout_1)
if (x_pcaout_1 (ii)>= 60)
        y_pcaout_1(ii)= 60;

%     else if (x_pcaout_1 (ii)< 0)
%              y_pcaout_1(ii)= 0;
else
         y_pcaout_1(ii)= x_pcaout_1(ii) ;
%         end
end
end
y_pcaout_1=smooth(y_pcaout_1,31)
plot(y_pcaout_1)

diff=x_pcaout_1-y_pcaout_1
subplot 513
diff=smooth(diff,17)
plot(diff)

index_xpca=[0:length(y_pcaout_1)-1]'
ys=polyfit(index_xpca,y_pcaout_1,8)
ys1=polyval(ys,y_pcaout_1)
subplot 514
plot(ys1)


d=x_pcaout_1-ys1
% fs=128;
% t=1/fs:1/fs:length(d)/fs;
subplot 515
plot(d)
     
hold on
[n1,peaks1]=findpeaks(d,'MINPEAKHEIGHT',170,'MINPEAKDISTANCE',20)     
stem(peaks1,n1,'*r')

index1=0
for i=1:length(peaks1)-1
if (abs(peaks1(i)-peaks1(i+1))<600)
index1(i)= 0
else
index1(i)= peaks1(i+1) 
end
end

index1=[peaks1(1) index1];


j=find(index1)

new_index_min= index1(j)-100
new_index_max=index1(j)+400



blink_1= d(new_index_min(1):new_index_max(1))
blink_2= d(new_index_min(2):new_index_max(2))
blink_3= d(new_index_min(3):new_index_max(3))
blink_4= d(new_index_min(4):new_index_max(4))
blink_5= d(new_index_min(5):new_index_max(5))




figure (5)  %peaks seperated plots

subplot 231
plot(blink_1)
hold on
[n_1,peaks_1]=findpeaks(blink_1,'MINPEAKHEIGHT',130,'MINPEAKDISTANCE',20);     
stem(peaks_1,n_1,'*r')
hold off

subplot 232
plot(blink_2)
hold on
[n_2,peaks_2]=findpeaks(blink_2,'MINPEAKHEIGHT',130,'MINPEAKDISTANCE',20);     
stem(peaks_2,n_2,'*r')
hold off

subplot 233
plot(blink_3)
hold on
[n_3,peaks_3]=findpeaks(blink_3,'MINPEAKHEIGHT',110,'MINPEAKDISTANCE',20);     
stem(peaks_3,n_3,'*r')
hold off

subplot 234
plot(blink_4)
hold on
[n_4,peaks_4]=findpeaks(blink_4,'MINPEAKHEIGHT',130,'MINPEAKDISTANCE',20);     
stem(peaks_4,n_4,'*r')
hold off

subplot 235
plot(blink_5)
hold on
[n_5,peaks_5]=findpeaks(blink_5,'MINPEAKHEIGHT',100,'MINPEAKDISTANCE',20);     
stem(peaks_5,n_5,'*r')
hold off



h_1=n_1
h_2=sum(n_2)
h_3=sum(n_3)
h_4=sum(n_4)
h_5=sum(n_5)


fft_blink_1=fft(blink_1)
fft_blink_2=fft(blink_2)
fft_blink_3=fft(blink_3)
fft_blink_4=fft(blink_4)
fft_blink_5=fft(blink_5)

g=length(fft_blink_1)/2
fft_blink_1=abs(fft_blink_1(1:g))
fft_blink_2=abs(fft_blink_2(1:g))
fft_blink_3=abs(fft_blink_3(1:g))
fft_blink_4=abs(fft_blink_4(1:g))
fft_blink_5=abs(fft_blink_5(1:g))


fs=128
df=(fs/2)/(length(fft_blink_1)-1)
freq=0:df:(fs/2)

figure (6)   %fft plot
subplot 231
plot(freq,(fft_blink_1))
subplot 232
plot(freq,(fft_blink_2))
subplot 233
plot(freq,(fft_blink_3))
subplot 234
plot(freq,(fft_blink_4))
subplot 235
plot(freq,(fft_blink_5))


fft_blink_1=smooth(fft_blink_1,3)  %smoothening fft outputs

fft_blink_2=smooth(fft_blink_2,3)


fft_blink_3=smooth(fft_blink_3,3)


fft_blink_4=smooth(fft_blink_4,3)

fft_blink_5=smooth(fft_blink_5,3)


figure (7) %smoothend outputs after fft
subplot 231
plot(fft_blink_1)

subplot 232
plot(fft_blink_2)

subplot 233
plot(fft_blink_3)

subplot 234
plot(fft_blink_4)

subplot 235
plot(fft_blink_5)



[n1,peaks1]=findpeaks(fft_blink_1,'MINPEAKHEIGHT',200,'MINPEAKDISTANCE',5)

figure (8) %peaks located plots
subplot 121
plot(freq,(fft_blink_1))
hold on
k=freq(peaks1)
subplot 121
plot(k,n1,'*r')
hold off

[n2,peaks2]=findpeaks(fft_blink_2,'MINPEAKHEIGHT',2000,'MINPEAKDISTANCE',5)
figure (8)
subplot 122
plot(freq,(fft_blink_2))
hold on
k=freq(peaks2)
subplot 122
plot(k,n2,'*r')
hold off

[n3,peaks3]=findpeaks(fft_blink_3,'MINPEAKHEIGHT',2000,'MINPEAKDISTANCE',5)

figure (9) %peaks located plots
subplot 121
plot(freq,(fft_blink_3))
hold on
k=freq(peaks3)
subplot 121
plot(k,n3,'*r')
hold off

[n4,peaks4]=findpeaks(fft_blink_4,'MINPEAKHEIGHT',2000,'MINPEAKDISTANCE',5)
figure (9)
subplot 122
plot(freq,(fft_blink_4))
hold on
k=freq(peaks4)
subplot 122
plot(k,n4,'*r')
hold off


[n5,peaks5]=findpeaks(fft_blink_5,'MINPEAKHEIGHT',2000,'MINPEAKDISTANCE',5)

figure (10) %peaks located plots
subplot 121
plot(freq,(fft_blink_5))
hold on
k=freq(peaks5)
subplot 121
plot(k,n5,'*r')
hold off

h_1=n_1
h_2=sum(n_2)
h_3=sum(n_3)
h_4=sum(n_4)
h_5=sum(n_5)


fft_blink_1=fft(blink_1)
fft_blink_2=fft(blink_2)
fft_blink_3=fft(blink_3)
fft_blink_4=fft(blink_4)
fft_blink_5=fft(blink_5)

g=length(fft_blink_1)/2
fft_blink_1=abs(fft_blink_1(1:g))
fft_blink_2=abs(fft_blink_2(1:g))
fft_blink_3=abs(fft_blink_3(1:g))
fft_blink_4=abs(fft_blink_4(1:g))
fft_blink_5=abs(fft_blink_5(1:g))


fs=128
df=(fs/2)/(length(fft_blink_1)-1)
freq=0:df:(fs/2)

figure (11)
r1=rceps(fft_blink_1)

r2=rceps(fft_blink_2)

r3=rceps(fft_blink_3)

r4=rceps(fft_blink_4)

r5=rceps(fft_blink_5)

subplot 231
plot(r1)
subplot 232
plot(r2)
subplot 233
plot(r3)
subplot 234
plot(r4)
subplot 235
plot(r5)


figure (12)
subplot 111
plot(log(abs(r1)))



f1=abs(fft_blink_1)
f2=abs(fft_blink_2)
f3=abs(fft_blink_3)
f4=abs(fft_blink_4)
f5=abs(fft_blink_5)


e1=sum(f1.^2);
e2=sum(f2.^2);
e3=sum(f3.^2);
e4=sum(f4.^2);
e5=sum(f5.^2);



