filename = 'E:\my pro\sample.xlsx';

range='A2:A91'
X1=xlsread(filename,range)

range='B2:B91'
X2=xlsread(filename,range)

range='C2:C91'
X3=xlsread(filename,range)

range='D2:D91'
X4=xlsread(filename,range)

range='E2:E91'
X5=xlsread(filename,range)

range='F2:F91'
X6=xlsread(filename,range)


filename = 'E:\my pro\training.xlsx';


range='A2:F2'
X7=xlsread(filename,range)

range='A3:F3'
X8=xlsread(filename,range)

range='A4:F4'
X9=xlsread(filename,range)

range='D2:F337'
X10=xlsread(filename,range)

range='E2:F337'
X11=xlsread(filename,range)

range='F2:F337'
X12=xlsread(filename,range)

Sample=[X1 X2 X3 X4 X5 X6]
Training=[X7 X8 X9 X10 X11 X12]
Group=[1 2 3 4 5 6 1 2 3 4 5 6]
class=knnclassify(Sample,Training,Group)



