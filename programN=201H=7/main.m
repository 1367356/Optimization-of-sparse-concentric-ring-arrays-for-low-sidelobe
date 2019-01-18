%%%条件与目的：阵元间距0.5*lamda，圆环数8，优化半径，使得旁瓣平最小
%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%每个圆环的阵元数分别为1 8 15 20 26 32 40 47 61 69
clc;
clear;
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%初始参数设置%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lamda=1;
circle_num=7;
element_num=201;         %输入为0，就是不限制阵元数目，输入为非0，就是有阵元总数的限制。
L=9.4;
element_space=0.5*lamda;
H=circle_num;
%L=circle_num*(1.5)+rand();
%-----遗传算法参数
genetic_num=2;%遗传代数
group_num=10;%种群数
%element_sum=201;
%trunc=0.5;%截断阀值（经验值）
%生成6圆环的随机数种群
Population_Init=zeros(circle_num+1,group_num);
%Perimeter=zeros(circle_num+1,group_num);%每个圆环周长

basic_distance=element_space:element_space:circle_num*element_space;
for group_i=1:group_num    %初始化种群半径，总共初始化了10个种群半径，从这10个半径组中，交叉变异，选择出最好的。
    exprnd_num=exprnd(0.5,1,circle_num);%产生指数序列
    redundance=L/2-circle_num*element_space;    %满足圆环之间阵元间距的情况下，剩下的冗余
    normalization_num=sort(exprnd_num/max(exprnd_num)*redundance);  %归一化*1.7
    group_i_radius=normalization_num+basic_distance;         %加上原来的半径
    for n=1:circle_num+1
        if n==1
           Population_Init(n,group_i)=0;
        else
            Population_Init(n,group_i)=group_i_radius(n-1); %R(1)=0
        end
    end
end

%%%%%%%%%%将其中一列替换为较好的数据
Population_Init(2,2)=0.7357;
Population_Init(3,2)= 1.2757;
Population_Init(4,2)= 1.7870;
Population_Init(5,2)= 2.4001;
Population_Init(6,2)=3.1842;
Population_Init(7,2)=3.9278;
Population_Init(8,2)=4.9800;

 Population_Init=sort(Population_Init);%%%%按列从小到大排列

%Population_next=Population_Init;
Tem_rsll=zeros(genetic_num,1);
optimal_path=zeros(genetic_num,1);
steps=genetic_num;
%hwait=waitbar(0,'请等待>>>>>>>>');
 step=steps/100;
golbal_Circle_element_num_store={}; %存储最优种群，每个圆环上的阵元个数。
optimal_path={};  %存储最优路径，圆环半径
optimal_parameter={}; %存储保留函数的参数
for genetic_i=1:genetic_num   %遗传代数
    genetic_i
    Rsll_it=zeros(group_num,1);%每一代的各个个体峰值旁瓣电平存储空间
    each_generation_Circle_element_num_store={};%存储每一代最优种群，每个圆环上的阵元个数。
    each_generation_optimal_parameter={}; %存储每一代最优种群保留函数的参数
    for m=1:group_num
        [Array,element_sum,Circle_element_num,parameter]=ArrayGroup(Population_Init,circle_num,m,element_space,element_num,genetic_i,group_num); 
                                                   %阵元总数142，Array是142个阵元的半径和角度（复数表示）的和，代表了每个阵元的位置
                                                   %m  第m个初始化种群半径组，将这个半径组传入，看会产生什么样的阵元位置。 
        Rsll_it(m)=rllofcircle(Array);%求阵列方向图以及峰值旁瓣电平
        Circle_element_num=Circle_element_num';
        %Circle_element_num=num2cell(Circle_element_num)
        each_generation_Circle_element_num_store{m}=Circle_element_num;
        each_generation_optimal_parameter{m}=parameter;
    end
     Tem_rsll(genetic_i)=min(Rsll_it);%找出最小峰值旁瓣电平
     [aftersort_Rsll_it,Index]=sort(Rsll_it);
     optimal_parameter{genetic_i}=each_generation_optimal_parameter(Index(1));
     golbal_Circle_element_num_store{genetic_i}=each_generation_Circle_element_num_store(Index(1));%对应这一代genetic_i的最优半径
     optimal_path{genetic_i}=Population_Init(:,Index(1))';
     %----生成下一代种群的随机数
     if genetic_i<genetic_num
         [Population_next]=nextgroup(Population_Init,Rsll_it,group_num,circle_num,L,element_space,genetic_i);
         Population_Init=Population_next;%%%%按列从小到大排列
     end
     rsll=min(Tem_rsll)
     %%%加进度条
end
a=1
sort(Tem_rsll)
[aftersort_Rsll_it,Index]=sort(Tem_rsll);
optimum_circle_number=golbal_Circle_element_num_store{Index(1)}{1}   %最优的每个圆环上有多少个元素。
Global_optimal_parameter=optimal_parameter{Index(1)}{1}
global_optimal_path=optimal_path{Index(1)}
% close(hwait);
%-----导出最优阵列
Population_Init=sort(Population_Init);
m=1;
[Array,element_sum,Circle_element_num,parameter]=ArrayGroup(Population_Init,circle_num,m,element_space,element_num,genetic_i,group_num);

Bestallarray=Array;
element_sum
element.sum1=numel(Bestallarray);
%Tem_rsll
% %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%优化结果展示%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----导出方向图
N_sam=1024;  %采样点数
u=-1:2/N_sam:1-2/N_sam;%u=sin(sita)*cos(fai)，U轴
v=-1:2/N_sam:1-2/N_sam;%v=sin(sita)*sin(fai)，V轴
[X,Y]=meshgrid(u,v);
FF=zeros(N_sam,N_sam);%采样矩阵
lamda=1;%波长

fun_x=find(Bestallarray~=0);     
%得到的结果为一列向量，有阵元的位置索引值，维数一般比quartered_matrix低，就是把
%没有阵元的位置去掉
q_position=[real(Bestallarray(fun_x)) imag((Bestallarray(fun_x)))]; 
%得到的结果为二维列向量，第一列幅值，第二列相位，行数和fun_x一样    
%-----下面这段代码就是方向图的计算 公式（2）和（3）只是转换为在直角坐标下面计算
for n=1:N_sam
    for m=1:N_sam
        if abs(v(m))<=sqrt(1-u(n)^2)% 数学推导合理性保证，限定在单位圆内部
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

FF(find(FF==0))=eps; %eps是非常小的一个数
ff=20*log10(abs(FF)/max(max(abs(FF))));%%归一化
bottom=-40;%设置底平台电平
ff(find(ff<=-40))=bottom;%最低电平设置为-80db
%when fai=0 ---ff(m,:) ---u axis   
%when fai=90 ---ff(:,m) ---v axis  when fai=45----u=v
m=ceil(find(ff==max(max(ff)))/N_sam);%在一个100*100的矩阵中找到最大值的位置
fai0=ff(m,:); fai90=ff(:,m);  

%-----uv图


figure
plot(u,fai0,'-b');
hold on
plot(v,fai90,'--r');
legend('u=0','v=0');
%ylabel('F(u,v)/dB');
%xlabel('μ,ν');
figure_FontSize=14;
set(get(gca,'XLabel'),'FontSize',figure_FontSize);
set(get(gca,'YLabel'),'FontSize',figure_FontSize);
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);

text(0.48,-10,'sampling number :1024','horiz','left','color','b','fontsize',7)
% text(0.5,-12,'PSLL：-19.34dB','horiz','left','color','b','fontsize',7)
text(0.48,-12,sprintf('PSLL:%0.2f',rsll),'horiz','left','color','b','fontsize',7);
text(0.76,-12,'dB','horiz','left','color','b','fontsize',7);
xlabel('u,v');
ylabel('Radiation pattern (dB)');

%-----方向图
figure
mesh(X,Y,ff);%画出曲面图
shading interp;
% colormap(gray);
xlabel('u=sin\theta cos φ');
ylabel('v=sin\theta sin φ');
zlabel('Radiation pattern (dB)');

%-----收敛图
figure

plot(Tem_rsll);

ylabel('PSLL/dB');
xlabel('Generation');
figure_FontSize=14;
set(get(gca,'XLabel'),'FontSize',figure_FontSize);
set(get(gca,'YLabel'),'FontSize',figure_FontSize);
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
hold on
after_sort=sort(Tem_rsll')
%-----阵元分布图
%---9同心圆

figure         %一张图片下面全是一张图片里的内容。
alpha=0:pi/20:2*pi;%角度[0,2*pi]
%Radius_edit=0.5*lamda*[1:1:aperture];%半径变化
Radius_edit=Population_Init(:,1);
Radius_edit';
for n=1:circle_num+1
    R=Radius_edit(n);%半径
    x=R*cos(alpha);
    y=R*sin(alpha);
    hold on
    plot(x,y,'--');
end
axis equal;%使坐标实际距离相等，方便显示为一个标准的圆形！！！！！！
%set(gca,'xlim',[-10 10],'xtick',-10:2:10);%设计坐标
set(gca,'xlim',[-(0.5*(circle_num+4)+0.5) 0.5*(circle_num+4)+0.5]);%设计坐标
set(gca,'ylim',[-(0.5*(circle_num+4)+0.5) 0.5*(circle_num+4)+0.5]);%使圆边界和坐标轴之间留有空白
figure_FontSize=14;
set(get(gca,'XLabel'),'FontSize',figure_FontSize);
set(get(gca,'YLabel'),'FontSize',figure_FontSize);
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',1);
hold on


text(2.8,5.2,sprintf('Element number:%0.0f',element_sum),'horiz','left','color','b','fontsize',7);
text(2.8,4.6,'element:','horiz','left','color','b','fontsize',7);
text(4.4,4.62,'o','horiz','left','color','b','fontsize',9);
ylabel('y(λ)');
xlabel('x(λ)');
%---阵元分布
for n=1:element_sum
    R=real(Bestallarray(n));%半径
    alpha=imag(Bestallarray(n));%角度[0,2*pi]
    x=R*cos(alpha);
    y=R*sin(alpha);
    hold on
    plot(x,y,'Marker','o');
end
axis([-6.3 6.3 -6.3 6.3])
toc


