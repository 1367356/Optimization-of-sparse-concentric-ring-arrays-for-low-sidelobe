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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%27.9
%        a =     -0.1479;
%        b =     0.00428 ;                              
%        c =      0.5492 ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3项合成
% a=[0.77	1.32	2.09	2.92	3.77	4.70     0.76          1.36            2.09         2.99         3.78         4.70    0.89       1.48       2.11      2.92     3.66      4.70]
% b=[9/9.68 16/16.59	26/26.26	30/36.69	27/47.38	33/59.06   9/9.55       17/17.09    26/26.26  31/37.57  26/47.50    33/59.06   10/11.18    16/18.59   23/26.51   27/36.69  25/45.99   31/59.06]
% Linear model:
%      f(x) = a*(sin(x-pi)) + b*((x-10)^2) + c
% Coefficients (with 95% confidence bounds):
% a =     -0.2129 ;% (-0.3045, -0.1213)
% b =   0.0006066 ;% (-0.002895, 0.004108)
% c =      0.7073 ;% (0.5242, 0.8904)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%28.15，
%haupt数据取整
%        a =     -0.1969 ;% (-0.4187, 0.02502)
%        b =     0.00228 ;% (-0.006065, 0.01062)
%        c =      0.6543 ;% (0.2139, 1.095)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% haupt数据
%         a =     -0.2302  ;%(-0.4354, -0.025)
%        b =   0.0004676 ;% (-0.00725, 0.008186)
%        c =      0.7352 ;% (0.3279, 1.143)

%        a =     -0.1289;%  (-0.1655, -0.09235)
%        b =    0.004673 ;% (0.003597, 0.005748)
%        c =      0.5193  ;%(0.4527, 0.5859)

%        a =     -0.2043;%  (-0.3814, -0.0272)
%        b =    0.002089  ;%(-0.004557, 0.008734)
%        c =      0.6646  ;%(0.3142, 1.015)

%        a =     -0.1785;%  (-0.2728, -0.08432)
%        b =     0.00193;%  (-0.001597, 0.005458)
%        c =      0.6628;%  (0.4764, 0.8492)
       
       
%        a =     -0.2551;%  (-0.3325, -0.1778)
%        b =  -0.0005217 ;%  (-0.003427, 0.002384)
%        c =       0.789 ;%  (0.6357, 0.9423)
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%大于28的结果
%         a =     -0.1538 ;% (-0.2078, -0.09973)
%        b =    0.004088  ;%(0.002347, 0.005828)
%        c =      0.5607  ;%(0.4597, 0.6618)

       a =     -0.1538  ;% (-0.2031, -0.1239)
       b =      0.0041  ;% (0.00199, 0.00505)
       c =       0.5607   ;%(0.5009, 0.6605)
%  
%%%%%%%%%%%%%%%%%%%%%大于28的结果
%        a =     -0.1414 ;% (-0.2439, -0.03884)
%        b =    0.004213;  %(0.001221, 0.007205)
%        c =      0.5523 ; %(0.3663, 0.7384)

%%%%%%%%%%%%%%%%%%%%%%%三个数据取整叠加，结果大于27.8
% 三项合成取整：
% a=[0.77	1.32	2.09	2.92	3.77	4.70     0.76          1.36            2.09         2.99         3.78         4.70   0.89       1.48       2.11       2.92    3.66      4.70]
% b=[9/9 16/16	26/26	30/36	27/47	33/59   9/9       17/17    26/26  31/37  26/47    33/59   10/11    16/18   23/26   27/36  25/45   31/59]
% Linear model:
%      f(x) = a*(sin(x-pi)) + b*((x-10)^2) + c
% Coefficients (with 95% confidence bounds):
%        a =     -0.1914 ;%  (-0.285, -0.09774)
%        b =    0.002059  ;% (-0.001522, 0.00564)
%        c =      0.6472  ;% (0.46, 0.8345)

%%%%%%%%%%%%%%%%%%%%%%%%%
%阵元个数为132，张帅论文结果
%       a =    -0.06559 ;% (-0.1609, 0.02969)
%       b =    0.005705  ;%(0.002857, 0.008554)
%       c =      0.4069  ;%(0.2321, 0.5818)
 %   a =    -0.1609+0.19059*rand() ;% (-0.1609, 0.02969)
  %  b =    0.002857+rand()*0.005697  ;%(0.002857, 0.008554)
  % c =      0.2321+rand()*0.3497  ;%(0.2321, 0.5818)
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
   
