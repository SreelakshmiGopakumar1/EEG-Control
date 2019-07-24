close all;
clear all;
clc;
len=0;
dif=[];
cccc=[];
%filename='E:\my pro';
final_mat=zeros(100,48);



for irr=92
    
    %irr=1:5

    % Importing Data
    file=strcat('baba (',int2str(irr),').csv')
    d=importdata(file)
    s=double(d.data)
    siz=size(s)
    
    % Eliminating first 50 and last 200 samples 
    ll=10:(siz(1)-120);

         % nnnn=3;

    ts1=s(ll,3);
    
    ts2=s(ll,4);
    ts3=s(ll,15);
    ts4=s(ll,16);
    figure
    fs=128;
t=(1:length(ts1))/fs;
    subplot(411)
    plot(t,ts1)
    subplot(412)
    plot(t,ts2)
    subplot(413)
    plot(t,ts3)
    subplot(414)
    plot(t,ts4)
    ll=ll';
    yarr=[ts1 ts2 ts3 ts4  ];% x4 x5 x6 x13 x14 x15 x16]
    % yarr=[ y3 y4 y15 y16]
     [COEFF,SCORE,latent] = princomp(yarr);
     figure
subplot(411)
x_pcaout_1=SCORE(:,1);
plot(t,x_pcaout_1)

subplot(412)
% x_pcaout_3=SCORE(:,3)
% plot(ll,x_pcaout_3)

X1=x_pcaout_1;
    % Base line removal using polynomial fit
    X1=X1-mean(X1);
   subplot(412)
   plot(t,X1)

    opol = 10;
    [p,shh1,mu] = polyfit(ll,X1,opol);
    f_y = polyval(p,ts1,[],mu);
    tsm1 = abs(X1 - f_y);
    
    % Base line removal in local

    tw1=smooth(tsm1,13);
    
    subplot(413)
   plot(t,tw1)
    
    %normalising
    twn1=tw1/(max(tw1));
    subplot(414)
   plot(t,twn1)

    
    % Finding peaks
    [n1,peaks1]=findpeaks(twn1,'MINPEAKHEIGHT',0.4,'MINPEAKDISTANCE',70);
    

 hold on;
 plot(t(peaks1),n1,'rv','MarkerFaceColor','r');
 hold off
 index1=0;
for i=1:length(peaks1)-1
if (abs(peaks1(i)-peaks1(i+1))<400)
index1(i)= 0;
else
index1(i)= peaks1(i+1); 
end
end

index1=[peaks1(1) index1];

j=find(index1);

new_index_min= index1(j)-100;
new_index_max=index1(j)+400;

blink_1= twn1(new_index_min(1):new_index_max(1));
blink_2= twn1(new_index_min(2):new_index_max(2));
blink_3= twn1(new_index_min(3):new_index_max(3));
blink_4= twn1(new_index_min(4):new_index_max(4));
blink_5= twn1(new_index_min(5):new_index_max(5));
blink_6= twn1(new_index_min(6):new_index_max(6));


figure (5)  %peaks seperated plots

subplot 331

u=(1:length(blink_1))/fs;
blink_1=blink_1-mean(blink_1);
plot(u,blink_1)

hold on
[n_1,peaks_1]=findpeaks(blink_1,'MINPEAKHEIGHT',0.2,'MINPEAKDISTANCE',20);     
stem(u(peaks_1),n_1,'*r');
hold off

subplot 332
blink_2=blink_2-mean(blink_2);
plot(u,blink_2)
hold on
[n_2,peaks_2]=findpeaks(blink_2,'MINPEAKHEIGHT',0.2,'MINPEAKDISTANCE',20);     
stem(u(peaks_2),n_2,'*r');
hold off

subplot 333
blink_3=blink_3-mean(blink_3);
plot(u,blink_3)
hold on
[n_3,peaks_3]=findpeaks(blink_3,'MINPEAKHEIGHT',0.2,'MINPEAKDISTANCE',20);     
stem(u(peaks_3),n_3,'*r')
hold off

subplot 334
blink_4=blink_4-mean(blink_4);
plot(u,blink_4)
hold on
[n_4,peaks_4]=findpeaks(blink_4,'MINPEAKHEIGHT',0.2,'MINPEAKDISTANCE',20);     
stem(u(peaks_4),n_4,'*r')
hold off

subplot 335
blink_5=blink_5-mean(blink_5);
plot(u,blink_5)
hold on
[n_5,peaks_5]=findpeaks(blink_5,'MINPEAKHEIGHT',0.2,'MINPEAKDISTANCE',20);     
stem(u(peaks_5),n_5,'*r')
hold off

subplot 336
blink_6=blink_6-mean(blink_6);
plot(u,blink_6)
hold on
[n_6,peaks_6]=findpeaks(blink_6,'MINPEAKHEIGHT',0.2,'MINPEAKDISTANCE',20);     
stem(u(peaks_6),n_6,'*r')
hold off

pl1=[n_1, peaks_1]
pl2=[n_2,peaks_2] 
pl3=[n_3,peaks_3] 
pl4=[n_4,peaks_4] 
pl5=[n_5,peaks_5] 
pl6=[n_6,peaks_6]

% ene_1=sum(abs(blink_1).^2)
% ene_2=sum(abs(blink_2).^2)
% ene_3=sum(abs(blink_3).^2)
% ene_4=sum(abs(blink_4).^2)
% ene_5=sum(abs(blink_5).^2)
% ene_6=sum(abs(blink_6).^2)
 
fft_blink_1=fft(blink_1);
fft_blink_2=fft(blink_2);
fft_blink_3=fft(blink_3);
fft_blink_4=fft(blink_4);
fft_blink_5=fft(blink_5);
fft_blink_6=fft(blink_6);

g=length(fft_blink_1)/2;
fft_blink_1=abs(fft_blink_1(1:g));
fft_blink_2=abs(fft_blink_2(1:g));
fft_blink_3=abs(fft_blink_3(1:g));
fft_blink_4=abs(fft_blink_4(1:g));
fft_blink_5=abs(fft_blink_5(1:g));
fft_blink_6=abs(fft_blink_6(1:g));

r1=rceps(fft_blink_1)

r2=rceps(fft_blink_2)

r3=rceps(fft_blink_3)

r4=rceps(fft_blink_4)

r5=rceps(fft_blink_5)

r6=rceps(fft_blink_6)

fs=128;
df=(fs/2)/(length(fft_blink_1)-1);
freq=0:df:(fs/2);

fft_blink_1=smooth(fft_blink_1,3);  %smoothening fft outputs

fft_blink_2=smooth(fft_blink_2,3);

fft_blink_3=smooth(fft_blink_3,3);

fft_blink_4=smooth(fft_blink_4,3);

fft_blink_5=smooth(fft_blink_5,3);

fft_blink_6=smooth(fft_blink_6,3);

figure (6)   %fft plot
subplot 611
plot(freq,abs(fft_blink_1))
subplot 612
plot(freq,abs(fft_blink_2))
subplot 613
plot(freq,abs(fft_blink_3))
subplot 614
plot(freq,abs(fft_blink_4))
subplot 615
plot(freq,abs(fft_blink_5))

subplot 616
plot(freq,abs(fft_blink_6))

figure (7) %peaks located plots
spec_en_1=sum(fft_blink_1.^2);
fft_blink_1=(fft_blink_1)/ (max((fft_blink_1)));

[n1,peaks1]=findpeaks(fft_blink_1,'MINPEAKHEIGHT',0.1,'MINPEAKDISTANCE',20);
subplot 121
plot(freq,(fft_blink_1))
hold on
k=freq(peaks1);
BW1=max(k);
subplot 121
plot(k,n1,'*r')
hold off
SP1=sum(n1);


spec_en_2=sum(fft_blink_2.^2);
fft_blink_2=(fft_blink_2)/ (max((fft_blink_2)));
[n2,peaks2]=findpeaks(fft_blink_2,'MINPEAKHEIGHT',0.1,'MINPEAKDISTANCE',3);


figure (7)
subplot 122
plot(freq,(fft_blink_2))
hold on
k2=freq(peaks2);
BW2=max(k2);
plot(k2,n2,'*r')
hold off
SP2=sum(n2);

figure (8)
spec_en_3=sum(fft_blink_3.^2);
fft_blink_3=(fft_blink_3)/ (max((fft_blink_3)));

[n3,peaks3]=findpeaks(fft_blink_3,'MINPEAKHEIGHT',0.1,'MINPEAKDISTANCE',3);

subplot 121
plot(freq,(fft_blink_3))
hold on
k3=freq(peaks3);
BW3=max(k3);
plot(k3,n3,'*r')
hold off
SP3=sum(n3);


spec_en_4=sum(fft_blink_4.^2);
fft_blink_4=(fft_blink_4)/ (max((fft_blink_4)));

[n4,peaks4]=findpeaks(fft_blink_4,'MINPEAKHEIGHT',0.1,'MINPEAKDISTANCE',3);

subplot 122
plot(freq,(fft_blink_4))
hold on
k4=freq(peaks4);
BW4=max(k4);
plot(k4,n4,'*r')
hold off
SP4=sum(n4);

spec_en_5=sum(fft_blink_5.^2);
fft_blink_5=(fft_blink_5)/ (max((fft_blink_5)));

[n5,peaks5]=findpeaks(fft_blink_5,'MINPEAKHEIGHT',0.1,'MINPEAKDISTANCE',3);

figure (9)
subplot 121
plot(freq,(fft_blink_5))
hold on
k5=freq(peaks5);
BW5=max(k5);
subplot 121
plot(k5,n5,'*r')
hold off
SP5=sum(n5);
spec_en_6=sum(fft_blink_6.^2);
fft_blink_6=(fft_blink_6)/ (max((fft_blink_6)));

[n6,peaks6]=findpeaks(fft_blink_6,'MINPEAKHEIGHT',0.1,'MINPEAKDISTANCE',3);
figure (9)
subplot 122
plot(freq,(fft_blink_6))
hold on
k6=freq(peaks6);
BW6=max(k6);
plot(k6,n6,'*r')
hold off
SP6=sum(n6);

% final_matrix= [a_height_u; a_height_v; a_sep_u; a_sep_v; a_wid_u; a_wid_v; a_snr; a_num;
% b_height_u; b_height_v; b_sep_u; b_sep_v; b_wid_u; b_wid_v; b_snr; b_num;
% c_height_u; c_height_v; c_sep_u; c_sep_v; c_wid_u; c_wid_v; c_snr; c_num;
% d_height_u; d_height_v; d_sep_u; d_sep_v; d_wid_u; d_wid_v; d_snr; d_num;
% e_height_u; e_height_v; e_sep_u; e_sep_v; e_wid_u; e_wid_v; e_snr; e_num;
% f_height_u; f_height_v; f_sep_u; f_sep_v; f_wid_u; f_wid_v; f_snr; f_num;];
% 
% final_mat(irr,:)=final_matrix'; 
% 
% 

final_spec_en(irr,:)=[spec_en_1 spec_en_2 spec_en_3 spec_en_4 spec_en_5 spec_en_6];
final_BW(irr,:)=[BW1 BW2 BW3 BW4 BW5 BW6];
final_SP(irr,:)=[SP1 SP2 SP3 SP4 SP5 SP6];
% final_pl(irr,:)=[pl1 pl2 pl3 pl4 pl5 pl6];
% final_rps(irr,:)=[r1 r2 r3 r4 r5 r6];
% final_ene(irr,:)=[ene_1 ene_2 ene_3 ene_4 ene_5 ene_6];


% 
% a_num=0; b_num=0; c_num=0; d_num=0; e_num=0; f_num=0;
end
final_spec_en=final_spec_en
final_BW=final_BW
final_SP=final_SP
% final_pl=final_pl
% final_rcps=final_rcps
% final_ene=final_ene

