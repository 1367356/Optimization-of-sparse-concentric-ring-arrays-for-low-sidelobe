function[Data]=roundn(Data,n)  %nÎªÕıÊı
% for i=1:length(Data)
%     a=Data(i)*(10^n);
%     a=round(a);
%     Data(i)=a/(10^n);
% end
a=Data*(10^n);
a=round(a);
Data=a/(10^n);
    