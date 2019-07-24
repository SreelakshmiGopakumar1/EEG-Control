filename = 'E:\my pro\sample.xlsx';

X1=xlsread(filename);
% X1dash=transpose(X1);
filename1 = 'E:\my pro\training.xlsx';

X2=xlsread(filename1);
% X2dash=transpose(X2);

filename2 = 'E:\my pro\group.xlsx';
X3=xlsread(filename2);

filename3 = 'E:\my pro\Book.xlsx';
X4=xlsread(filename3);


class=knnclassify(X1,X2,X3,12)

stats = confusionmatStats(class,X4)