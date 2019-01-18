function[rateofradius]=save_rate_of_radius(radius,a,b,c)
%radius  圆环的半径
%拟合函数的参数
%本函数用来求，给定半径和拟合参数时，这个圆环上阵元应该保留的概率
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-28.0803
%     f(x) = a*(sin(x-pi)) + b*((x-10)^2) + c
%Coefficients (with 95% confidence bounds):
%        a =     -0.1289;%  (-0.1655, -0.09235)
%        b =    0.004673 ;% (0.003597, 0.005748)
%        c =      0.5193  ;%(0.4527, 0.5859)
%        rateofradius=a*(sin(radius-pi)) + b*((radius-10)^2) + c;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-27.82

%        a =     -0.1414 ;% (-0.2439, -0.03884)
%        b =    0.004213;  %(0.001221, 0.007205)
%        c =      0.5523 ; %(0.3663, 0.7384)
%        rateofradius=a*(sin(radius-pi)) + b*((radius-10)^2) + c;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Sum of  line%%%%%%%%%
% a1 =       1.011;%  (0.9469, 1.075)
% b1 =      0.2433 ;%(0.1657, 0.321)
% c1 =        1.49  ;%(1.156, 1.825)
% rateofradius =  a1*sin(b1*radius+c1);
% if rateofradius>1
%    rateofradius=1;
% end
% if rateofradius <0
%    rateofradius=0;
% end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%linear   model %%%%%%%%%%%%%
%[14个数据]
%27.82db,28.03db
% a =     -0.1927+rand()*0.0897  ;%(-0.1927, -0.103)
% b =     0.002972+0.002615*rand()  ;%(0.002972, 0.005587)
% c =      0.4679+rand()*0.1625  ;%(0.4679, 0.6304)
%        a =     -0.1479
%        b =     0.00428                                    (5)
%        c =      0.5492 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%28.18db,28.19db
% Linear model:
%      f(x) = a*(sin(x-pi)) + b*((x-10)^2) + c
% Coefficients (with 95% confidence bounds):
%        a =     -0.104+rand()*0.05;%  (-0.1525, -0.1044)
%        b =    0.003882+rand()*0.00142 ;% (0.003883, 0.005301)
%        c =      0.4786+0.0878*rand()  ;%(0.4786, 0.5664)

% Goodness of fit:
%   SSE: 0.005383
%   R-square: 0.9882
%   Adjusted R-square: 0.9861
%   RMSE: 0.02212
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rateofradius=a*(sin(radius-pi)) + b*((radius-10)^2) + c;
       %a0 =      0.7543  (0.4253, 1.083)
      % a1 =      0.1981  (-0.2391, 0.6353)
       %b1 =      0.1444  (-0.1747, 0.4634)
       w =      0.7073 ;% (-0.3502, 1.765)
%rateofradius =  a + b*cos(radius*w) + c*sin(radius*w);
if radius<1.3
   rateofradius=1;
end
if rateofradius>1
   rateofradius=1;
end
if rateofradius <0
   rateofradius=0;
end