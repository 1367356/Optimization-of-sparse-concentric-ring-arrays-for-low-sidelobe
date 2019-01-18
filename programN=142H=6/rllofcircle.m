%--------------------------------程序简介----------------------------------%
%子函数名：圆阵方向图及峰值电平计算函数
%函数功能：计算圆阵的方向图以及峰值旁瓣电平值

function rsll=rllofcircle(quartered_matrix)
%----参数意义
%quartered_matrix圆阵阵元位置

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%采样参数设置%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N_sam=100;  %采样点数
u=-1:2/N_sam:1-2/N_sam;%u=sin(sita)*cos(fai)，U轴
v=-1:2/N_sam:1-2/N_sam;%v=sin(sita)*sin(fai)，V轴
FF=zeros(N_sam,N_sam);%采样矩阵


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%计算方向图函数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fun_x=find(quartered_matrix~=0);     
%得到的结果为一列向量，有阵元的位置索引值，维数一般比quartered_matrix低，就是把
%没有阵元的位置去掉
q_position=[real(quartered_matrix(fun_x)) imag((quartered_matrix(fun_x)))]; 
%得到的结果为二维列向量，第一列幅值，第二列相位，行数和fun_x一样  

%-----下面这段代码就是方向图的计算 公式（2）和（3）只是转换为在直角坐标下面计算
for n=1:N_sam
    for m=1:N_sam
        if abs(v(m))<=sqrt(1-u(n)^2)% 数学推导合理性保证，限定在单位圆内部,   u(n)^2+v(m)^2<=1,根据上面u=sin(sita)*cos(fai),v=sin(sita)*sin(fai)可得。
           temp=0;
           for a=1:length(fun_x)%把所有阵元的用上的，所以应该是整个圆平面  
               temp=temp+exp(j*2*pi*q_position(a,1)*(cos(q_position(a,2))...
                       *u(n)+sin(q_position(a,2))*v(m)));
           end
           FF(n,m)=temp+1;%加上圆心        
       else 
       end
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%计算旁瓣电平%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----以下部分是公共的
FF(find(FF==0))=eps; %eps是非常小的一个数
ff=20*log10(abs(FF)/max(max(abs(FF))));%%归一化
bottom=-40;%设置底平台电平
ff(find(ff<=-40))=bottom;%最低电平设置为-40db
%when fai=0 ---ff(m,:) ---u axis   
%when fai=90 ---ff(:,m) ---v axis  when fai=45----u=v
m=ceil(find(ff==max(max(ff)))/N_sam);%在一个100*100的矩阵中找到最大值的位置
%如果最大值有很多个，取其中的一个
fai0=ff(m,:); fai90=ff(:,m);           
%m的取值范围为1到100之间的整数，取出m所在的行和列，就是主瓣所在的行和列
%for t=1:N_sam 
%    fai45(t)=ff(t,t);
%end
%if (m<100)&&(m>1)
   tu_up=0; 
 while (fai0(m+tu_up)>=fai0(m+tu_up+1))%要切除U轴的量 上下
    tu_up=tu_up+1;
   if (m+tu_up)>=100
       break
   end
 end
  tu_down=0;
 while (fai0(m-tu_down)>=fai0(m-tu_down-1))
    tu_down=tu_down+1;
   if (m-tu_down)<=1
       break
   end
end
 fai0(m-tu_down:m+tu_up)=bottom;sll_0=max(fai0);

tv_up=0;                                              
while (fai90(m+tv_up)>=fai90(m+tv_up+1))%要切除V轴的量 上下
   tv_up=tv_up+1;
   if (m+tu_up)>=100
       break
   end
end
tv_down=0;
while (fai90(m-tv_down)>=fai90(m-tv_down-1))
    tv_down=tv_down+1;
   if (m-tv_down)<1
       break
   end
end

fai90(m-tv_down:m+tv_up)=bottom;sll_90=max(fai90);
%end
ff_overall=ff; 
ff_overall(m-tv_down:m+tv_up,m-tu_down:m+tu_up)=bottom;%去除主瓣 
%把主瓣限定为最小值，但是这样限定的好像不仅仅是主瓣区域
rsll=max(max(ff_overall));                           %得到最大旁瓣电平
