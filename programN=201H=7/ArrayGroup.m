function [Array,element_sum,Circle_element_num,parameter]=ArrayGroup(Population_Init,circle_num,group_i,element_space,element_num,genetic_i,group_num)
%parameter  拟合函数的参数
%element_num  整个阵列的阵元个数
Perimeter=zeros(circle_num+1,1);
Circle_element_num=zeros(circle_num+1,1);  %每个圆环上有多少个阵元
Element_alpha=zeros(circle_num+1,1);

for circle_i=2:circle_num+1
    Perimeter(circle_i)=Population_Init(circle_i,group_i)*2*pi;    %各个圆环的半径存储起来。
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%每个圆环上的阵元数和保留比率    
Circle_element_num(1,1)=1;
Circle_element_num(2)=fix((Population_Init(2,group_i)*2*pi)/element_space);
%%%%%%%%%%%%%%%%%%%%%%%%%%
%a =     -0.1927+rand()*0.0897  ;%(-0.1927, -0.103)
%b =     0.002972+0.002615*rand()  ;%(0.002972, 0.005587)
%c =      0.4679+rand()*0.1625  ;%(0.4679, 0.6304)
%        a =     -0.1928  ;%(-0.2816, -0.104)
%        b =    0.001384  ;%(-0.002002, 0.004771)
%        c =      0.6667  ;%(0.4894, 0.8439)
%        a =      0.7543 ;% (0.4253, 1.083)
%        b =      0.1981 ;% (-0.2391, 0.6353)
%        c =      0.1444  ;%(-0.1747, 0.4634)
%每个种群所对应的概率参数
% a =     -0.2927+rand()*0.2897  ;%(-0.1927, -0.103)
% b =     0.000972+0.007615*rand()  ;%(0.002972, 0.005587)
% c =      0.2679+rand()*0.5625  ;%(0.4679, 0.6304)
% a=-0.1857 ;
% b=0.0037;
% c=0.6225;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%25.85
       a =   -0.007238 ; % (-0.122, 0.1075)
       b =    0.003587 ; % (-0.0007898, 0.007964)
       c =      0.6973  ; %(0.4739, 0.9208)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=3:circle_num
    p=save_rate_of_radius(Population_Init(k,group_i),a,b,c);
     Circle_element_num(k)=fix((Population_Init(k,group_i)*2*pi)/element_space*p);
end

%%%%%%%%%%%%%%%%%%%%%%%%Circle_element_num(circle_num+1)=element_num-sum(Circle_element_num(1:circle_num));
if element_num==0
     p=save_rate_of_radius(Population_Init(circle_num+1,group_i),a,b,c);
     Circle_element_num(circle_num+1)=fix((Population_Init(circle_num+1,group_i)*2*pi)/element_space*p);
else
    if element_num-sum(Circle_element_num(1:circle_num))<=0
        Circle_element_num(circle_num+1)=0;
    else
        Circle_element_num(circle_num+1)=element_num-sum(Circle_element_num(1:circle_num));
    end
end
parameter=[a,b,c];
for circle_i=2:circle_num+1
    Element_alpha(circle_i)=2*pi/Circle_element_num(circle_i); %每个圆环上，两个阵元间的角度。
end
element_sum=sum(Circle_element_num);
% Array=zeros(element_sum,1);
Array_1=zeros(element_sum,1);%半径阵列
Array_2=zeros(element_sum,1);%角度阵列
%----生成圆环满阵

for i=1:circle_num+1
 for k=1:Circle_element_num(i) 
     sum2=sum(Circle_element_num(1:i-1));
     locat=sum2+k;
     Array_1(locat)=Population_Init(i,group_i);%半径
     Array_2(locat)=(k-1)*Element_alpha(i);%角度
 end
end
Array=Array_1+Array_2*j;
   
