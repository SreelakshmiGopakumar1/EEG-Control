close all;
clear all;
clc;
len=0;
dif=[];
cccc=[];
filename='C:\Users\USER\Desktop\eeg_movements\eeg frm sai baba\final_code.CSV';
final_mat=zeros(100,48);



% names(1,1)='a_height_u'; names(2,1)='a_height_v'; names(3,1)='a_sep_u'; names(4,1)='a_sep_v'; names(5,1)='a_wid_u'; names(6,1)='a_wid_v'; names(7,1)='a_snr'; names(8,1)='a_num'; 
% 'b_height_u'; 'b_height_v'; 'b_sep_u'; 'b_sep_v'; 'b_wid_u'; 'b_wid_v'; 'b_snr'; 'b_num'; 'c_height_u'; 'c_height_v'; 'c_sep_u'; 'c_sep_v'; 'c_wid_u'; 'c_wid_v'; 'c_snr'; 'c_num'; 'd_height_u'; 'd_height_v'; 'd_sep_u'; 'd_sep_v'; 'd_wid_u'; 'd_wid_v'; 'd_snr'; 'd_num'; 'e_height_u'; 'e_height_v'; 'e_sep_u'; 'e_sep_v'; 'e_wid_u'; 'e_wid_v'; 'e_snr'; 'e_num'; 'f_height_u'; 'f_height_v'; 'f_sep_u'; 'f_sep_v'; 'f_wid_u'; 'f_wid_v'; 'f_snr'; 'f_num';
% xlswrite(filename,names)

% Initialsing output variable
a_height_u=0; a_height_v=0; a_sep_u=0; a_sep_v=0; a_wid_u=0; a_wid_v=0; a_snr=0; a_num=0;
b_height_u=0; b_height_v=0; b_sep_u=0; b_sep_v=0; b_wid_u=0; b_wid_v=0; b_snr=0; b_num=0;
c_height_u=0; c_height_v=0; c_sep_u=0; c_sep_v=0; c_wid_u=0; c_wid_v=0; c_snr=0; c_num=0;
d_height_u=0; d_height_v=0; d_sep_u=0; d_sep_v=0; d_wid_u=0; d_wid_v=0; d_snr=0; d_num=0;
e_height_u=0; e_height_v=0; e_sep_u=0; e_sep_v=0; e_wid_u=0; e_wid_v=0; e_snr=0; e_num=0;
f_height_u=0; f_height_v=0; f_sep_u=0; f_sep_v=0; f_wid_u=0; f_wid_v=0; f_snr=0; f_num=0;


for irr=2:5

    % Importing Data
    file=strcat('baba (',int2str(irr),').csv');
    d=importdata(file);
    s=double(d.data);
    siz=size(s);
    
    % Eliminating first 50 and last 200 samples 
    ll=50:(siz(1)-250);
    
%     Selecting Channel
%     if irr==14
          nnnn=3;
% 
%     elseif irr==28
%         nnnn=3;
%     elseif irr==87
%          nnnn=3;
%     elseif irr==75
%         nnnn=3;
%     else
%         nnnn=4;        
%     end
    ts1=s(ll,nnnn);
    ll=ll';
    
    % Base line removal using polynomial fit
    opol = 10;
    [p,shh1,mu] = polyfit(ll,ts1,opol);
    f_y = polyval(p,ts1,[],mu);
    tsm1 = ts1 - f_y;
    
    % Base line removal in local
    tt1 = tsmovavg(tsm1,'s',10,1);
    tw1=tsm1-tt1;
    tw1=smooth(tw1,15);
    
    %normalising
    twn1=tw1/max(tw1);
    qwe=twn1;
    twn1=exp(twn1);
    twn1=twn1-1;
    twn1=twn1/max(twn1);
    twn1=exp(twn1);
    twn1=twn1-1;
    twn1=twn1/max(twn1);
    
    % Finding peaks
    [n1,peaks1]=findpeaks(twn1,'MINPEAKHEIGHT',0.22,'MINPEAKDISTANCE',20);
    
%     figure;
%     
%     plot(twn1);
%     hold on;
%     plot(peaks1,twn1(peaks1),'rv','MarkerFaceColor','r');
%     title(irr);
%     hold off;
%     
    % Diference between two consecutive postions in a peak
    df=[diff(peaks1); 0];
    asdf=(df>200);
    qwer=find(asdf);
    start_noise=peaks1((qwer(length(qwer))))+25;
    en_noise=peaks1(((qwer(length(qwer)))+1))-25;
    num_of_noi=en_noise-start_noise;
    
    
    noi=qwe(start_noise:en_noise);
    trg=sum(abs(noi));
    noi_enr=trg/num_of_noi;
    
    
    
    bl=0*peaks1;
    st=1;
    pos=peaks1(1);
    for ii=1:length(peaks1)
        bl(ii)=st;
        if(df(ii)>120)
            pos=[pos; peaks1(ii+1)];
            st=st+1;
        end
        % pos is the start position of the window
        % bl is the
    end
    
    
    df = [0; df];
    posr=peaks1(length(peaks1));
    for iii=length(peaks1):-1:1
       
        if(df(iii)>120)
            posr=[posr; peaks1(iii-1)];
        end      
        
    end
    posr=flipud(posr);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    blm=zeros(max(bl),1);
    for i=1:max(bl)
        c=histc(bl,i);
        blm(c)=c;
        
    end
    cccc=[cccc; blm];    
    len=[len numel(pos)];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for ii=1:length(pos)
        a=(peaks1>=pos(ii) & peaks1<=posr(ii));
        v=hist(a);
        n=v(10);
        xxx=peaks1.*a;
        ggg=find(xxx);
        pea=peaks1(ggg);
        
        if(n==1)
            a_num=a_num+1;
            a_height_u=twn1(pos(ii));
            
            hpower=twn1(pea)/2;
            wid=zeros(n,1);
            for wil=1:n
                a=pea(wil);
                ee=((a-15):1:(a+15));
                ee=ee';
                llll=twn1(ee);
                rrr=(llll>hpower(wil));
                pty=(rrr.*ee);
                p_p=find(pty);
                wid(wil)=max(p_p)-min(p_p);
            end
            a_wid_u=mean(wid);
            a_wid_v=var(wid);
            clear wid;
            
            a_start=pos(ii)-10;
            a_end=posr(ii)+10;
            
            num_of_noi=a_end-a_start;
            noia=qwe(a_start:a_end);
            trga=sum(abs(noia));
            noi_enra=trga/num_of_noi;
            
            a_snr=noi_enra/noi_enr;
            
        end
        if(n==2)
            b_num=b_num+1;
            b_height_u=mean(twn1(pea));
            b_height_u=(b_height_u.*2);
            b_height_v=var(twn1(pea));
            b_height_v=(b_height_v.*2);
            
            sepf=diff(pea);
            b_sep_u=sepf;
            
            hpower=twn1(pea)/2;
            wid=zeros(n,1);
            for wil=1:n
                a=pea(wil);
                ee=((a-15):1:(a+15));
                ee=ee';
                llll=twn1(ee);
                rrr=(llll>hpower(wil));
                pty=(rrr.*ee);
                p_p=find(pty);
                wid(wil)=max(p_p)-min(p_p);
            end
            b_wid_u=mean(wid);
            b_wid_u=(b_wid_u.*2);
            b_wid_v=var(wid);
            b_wid_v=(b_wid_v.*2);
            clear wid;
            
            
            b_start=pos(ii)-10;
            b_end=posr(ii)+10;
            
            num_of_noi=b_end-b_start;
            noib=qwe(b_start:b_end);
            trgb=sum(abs(noib));
            noi_enrb=trgb/num_of_noi;
            
            b_snr=noi_enrb/noi_enr;
            
        end
        if(n==3)
            c_num=c_num+1;
            c_height_u=mean(twn1(pea));
            c_height_u=(c_height_u*3);
            c_height_v=var(twn1(pea));
            c_height_v=(c_height_v*3);
            
            sepf=diff(pea);
            c_sep_u=mean(sepf);
            c_sep_v=var(sepf);
            
            hpower=twn1(pea)/2;
            wid=zeros(n,1);
            for wil=1:n
                a=pea(wil);
                ee=((a-15):1:(a+15));
                ee=ee';
                llll=twn1(ee);
                rrr=(llll>hpower(wil));
                pty=(rrr.*ee);
                p_p=find(pty);
                wid(wil)=max(p_p)-min(p_p);
            end
            c_wid_u=mean(wid);
            c_wid_u=(c_wid_u*3);
            c_wid_v=var(wid);
            c_wid_v=(c_wid_v*3);
            clear wid;
            
            c_start=pos(ii)-10;
            c_end=posr(ii)+10;
            
            num_of_noi=c_end-c_start;
            noic=qwe(c_start:c_end);
            trgc=sum(abs(noic));
            noi_enrc=trgc/num_of_noi;
            
            c_snr=noi_enrc/noi_enr;
            
        end
        if(n==4)
            d_num=d_num+1;
            d_height_u=mean(twn1(pea));
            d_height_u=(d_height_u*4);
            d_height_v=var(twn1(pea));
            rhrfh=d_height_v;
            d_height_v=(d_height_v*4);
            sepf=diff(pea);
            d_sep_u=mean(sepf);
            d_sep_v=var(sepf);
            
            
            hpower=twn1(pea)/2;
            wid=zeros(n,1);
            for wil=1:n
                a=pea(wil);
                ee=((a-15):1:(a+15));
                ee=ee';
                llll=twn1(ee);
                rrr=(llll>hpower(wil));
                pty=(rrr.*ee);
                p_p=find(pty);
                wid(wil)=max(p_p)-min(p_p);
            end
            d_wid_u=mean(wid);
            d_wid_u=(d_wid_u*4);
            d_wid_v=var(wid);
            d_wid_v=(d_wid_v*4);
            clear wid;
            
            d_start=pos(ii)-10;
            d_end=posr(ii)+10;
            
            num_of_noi=d_end-d_start;
            noid=qwe(d_start:d_end);
            trgd=sum(abs(noid));
            noi_enrd=trgd/num_of_noi;
            
            d_snr=noi_enrd/noi_enr;
            
            
        end
        if(n==5)
            e_num=e_num+1;
            e_height_u=mean(twn1(pea));
            e_height_u=(e_height_u*5);
            e_height_v=var(twn1(pea));
            e_height_v=(e_height_v*5);
            sepf=diff(pea);
            e_sep_u=mean(sepf);
            e_sep_v=var(sepf);
            
            hpower=twn1(pea)/2;
            wid=zeros(n,1);
            for wil=1:n
                a=pea(wil);
                ee=((a-15):1:(a+15));
                ee=ee';
                llll=twn1(ee);
                rrr=(llll>hpower(wil));
                pty=(rrr.*ee);
                p_p=find(pty);
                wid(wil)=max(p_p)-min(p_p);
            end
            e_wid_u=mean(wid);
            e_wid_u=(e_wid_u*5);
            e_wid_v=var(wid);
            e_wid_v=(e_wid_v*5);
            clear wid;
            
            e_start=pos(ii)-10;
            e_end=posr(ii)+10;
            
            num_of_noi=e_end-e_start;
            noie=qwe(e_start:e_end);
            trge=sum(abs(noie));
            noi_enre=trge/num_of_noi;
            
            e_snr=noi_enre/noi_enr;
            
        end
    
        if(n==6)
            f_num=f_num+1;
            f_height_u=mean(twn1(pea));
            f_height_u=(f_height_u*6);
            f_height_v=var(twn1(pea));
            f_height_v=(f_height_v*6);
            
            sepf=diff(pea);
            f_sep_u=mean(sepf);
            f_sep_v=var(sepf);
            hpower=twn1(pea)/2;
            wid=zeros(n,1);
            for wil=1:n
                a=pea(wil);
                ee=((a-15):1:(a+15));
                ee=ee';
                llll=twn1(ee);
                rrr=(llll>hpower(wil));
                pty=(rrr.*ee);
                p_p=find(pty);
                wid(wil)=max(p_p)-min(p_p);
            end
            f_wid_u=mean(wid);
            f_wid_u=(f_wid_u*6);
            f_wid_v=var(wid);
            f_wid_v=(f_wid_v*6);
            clear wid;
            
            f_start=pos(ii)-10;
            f_end=posr(ii)+10;
            
            num_of_noi=f_end-f_start;
            noif=qwe(f_start:f_end);
            trgf=sum(abs(noif));
            noi_enrf=trgf/num_of_noi;
            
            f_snr=noi_enrf/noi_enr;
            
        end
        
        
    end
final_matrix= [a_height_u; a_height_v; a_sep_u; a_sep_v; a_wid_u; a_wid_v; a_snr; a_num;
b_height_u; b_height_v; b_sep_u; b_sep_v; b_wid_u; b_wid_v; b_snr; b_num;
c_height_u; c_height_v; c_sep_u; c_sep_v; c_wid_u; c_wid_v; c_snr; c_num;
d_height_u; d_height_v; d_sep_u; d_sep_v; d_wid_u; d_wid_v; d_snr; d_num;
e_height_u; e_height_v; e_sep_u; e_sep_v; e_wid_u; e_wid_v; e_snr; e_num;
f_height_u; f_height_v; f_sep_u; f_sep_v; f_wid_u; f_wid_v; f_snr; f_num;];

final_mat(irr,:)=final_matrix'; 


% a_height_u=0; a_height_v=0; a_sep_u=0; a_sep_v=0; a_wid_u=0; a_wid_v=0; a_snr=0; a_num=0;
% b_height_u=0; b_height_v=0; b_sep_u=0; b_sep_v=0; b_wid_u=0; b_wid_v=0; b_snr=0; b_num=0;
% c_height_u=0; c_height_v=0; c_sep_u=0; c_sep_v=0; c_wid_u=0; c_wid_v=0; c_snr=0; c_num=0;
% d_height_u=0; d_height_v=0; d_sep_u=0; d_sep_v=0; d_wid_u=0; d_wid_v=0; d_snr=0; d_num=0;
% e_height_u=0; e_height_v=0; e_sep_u=0; e_sep_v=0; e_wid_u=0; e_wid_v=0; e_snr=0; e_num=0;
% f_height_u=0; f_height_v=0; f_sep_u=0; f_sep_v=0; f_wid_u=0; f_wid_v=0; f_snr=0; f_num=0;
% 
% a_num=0; b_num=0; c_num=0; d_num=0; e_num=0; f_num=0;
end

% ppp=len';
% No_of_Windows=ppp(2:length(ppp));
% display(No_of_Windows);
% 
% Pulse_detected=cccc;
% display(Pulse_detected);






