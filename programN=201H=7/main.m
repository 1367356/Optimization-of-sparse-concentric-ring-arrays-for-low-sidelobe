%%%������Ŀ�ģ���Ԫ���0.5*lamda��Բ����8���Ż��뾶��ʹ���԰�ƽ��С
%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%ÿ��Բ������Ԫ���ֱ�Ϊ1 8 15 20 26 32 40 47 61 69
clc;
clear;
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ʼ��������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lamda=1;
circle_num=7;
element_num=201;         %����Ϊ0�����ǲ�������Ԫ��Ŀ������Ϊ��0����������Ԫ���������ơ�
L=9.4;
element_space=0.5*lamda;
H=circle_num;
%L=circle_num*(1.5)+rand();
%-----�Ŵ��㷨����
genetic_num=2;%�Ŵ�����
group_num=10;%��Ⱥ��
%element_sum=201;
%trunc=0.5;%�ضϷ�ֵ������ֵ��
%����6Բ�����������Ⱥ
Population_Init=zeros(circle_num+1,group_num);
%Perimeter=zeros(circle_num+1,group_num);%ÿ��Բ���ܳ�

basic_distance=element_space:element_space:circle_num*element_space;
for group_i=1:group_num    %��ʼ����Ⱥ�뾶���ܹ���ʼ����10����Ⱥ�뾶������10���뾶���У�������죬ѡ�����õġ�
    exprnd_num=exprnd(0.5,1,circle_num);%����ָ������
    redundance=L/2-circle_num*element_space;    %����Բ��֮����Ԫ��������£�ʣ�µ�����
    normalization_num=sort(exprnd_num/max(exprnd_num)*redundance);  %��һ��*1.7
    group_i_radius=normalization_num+basic_distance;         %����ԭ���İ뾶
    for n=1:circle_num+1
        if n==1
           Population_Init(n,group_i)=0;
        else
            Population_Init(n,group_i)=group_i_radius(n-1); %R(1)=0
        end
    end
end

%%%%%%%%%%������һ���滻Ϊ�Ϻõ�����
Population_Init(2,2)=0.7357;
Population_Init(3,2)= 1.2757;
Population_Init(4,2)= 1.7870;
Population_Init(5,2)= 2.4001;
Population_Init(6,2)=3.1842;
Population_Init(7,2)=3.9278;
Population_Init(8,2)=4.9800;

 Population_Init=sort(Population_Init);%%%%���д�С��������

%Population_next=Population_Init;
Tem_rsll=zeros(genetic_num,1);
optimal_path=zeros(genetic_num,1);
steps=genetic_num;
%hwait=waitbar(0,'��ȴ�>>>>>>>>');
 step=steps/100;
golbal_Circle_element_num_store={}; %�洢������Ⱥ��ÿ��Բ���ϵ���Ԫ������
optimal_path={};  %�洢����·����Բ���뾶
optimal_parameter={}; %�洢���������Ĳ���
for genetic_i=1:genetic_num   %�Ŵ�����
    genetic_i
    Rsll_it=zeros(group_num,1);%ÿһ���ĸ��������ֵ�԰��ƽ�洢�ռ�
    each_generation_Circle_element_num_store={};%�洢ÿһ��������Ⱥ��ÿ��Բ���ϵ���Ԫ������
    each_generation_optimal_parameter={}; %�洢ÿһ��������Ⱥ���������Ĳ���
    for m=1:group_num
        [Array,element_sum,Circle_element_num,parameter]=ArrayGroup(Population_Init,circle_num,m,element_space,element_num,genetic_i,group_num); 
                                                   %��Ԫ����142��Array��142����Ԫ�İ뾶�ͽǶȣ�������ʾ���ĺͣ�������ÿ����Ԫ��λ��
                                                   %m  ��m����ʼ����Ⱥ�뾶�飬������뾶�鴫�룬�������ʲô������Ԫλ�á� 
        Rsll_it(m)=rllofcircle(Array);%�����з���ͼ�Լ���ֵ�԰��ƽ
        Circle_element_num=Circle_element_num';
        %Circle_element_num=num2cell(Circle_element_num)
        each_generation_Circle_element_num_store{m}=Circle_element_num;
        each_generation_optimal_parameter{m}=parameter;
    end
     Tem_rsll(genetic_i)=min(Rsll_it);%�ҳ���С��ֵ�԰��ƽ
     [aftersort_Rsll_it,Index]=sort(Rsll_it);
     optimal_parameter{genetic_i}=each_generation_optimal_parameter(Index(1));
     golbal_Circle_element_num_store{genetic_i}=each_generation_Circle_element_num_store(Index(1));%��Ӧ��һ��genetic_i�����Ű뾶
     optimal_path{genetic_i}=Population_Init(:,Index(1))';
     %----������һ����Ⱥ�������
     if genetic_i<genetic_num
         [Population_next]=nextgroup(Population_Init,Rsll_it,group_num,circle_num,L,element_space,genetic_i);
         Population_Init=Population_next;%%%%���д�С��������
     end
     rsll=min(Tem_rsll)
     %%%�ӽ�����
end
a=1
sort(Tem_rsll)
[aftersort_Rsll_it,Index]=sort(Tem_rsll);
optimum_circle_number=golbal_Circle_element_num_store{Index(1)}{1}   %���ŵ�ÿ��Բ�����ж��ٸ�Ԫ�ء�
Global_optimal_parameter=optimal_parameter{Index(1)}{1}
global_optimal_path=optimal_path{Index(1)}
% close(hwait);
%-----������������
Population_Init=sort(Population_Init);
m=1;
[Array,element_sum,Circle_element_num,parameter]=ArrayGroup(Population_Init,circle_num,m,element_space,element_num,genetic_i,group_num);

Bestallarray=Array;
element_sum
element.sum1=numel(Bestallarray);
%Tem_rsll
% %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�Ż����չʾ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----��������ͼ
N_sam=1024;  %��������
u=-1:2/N_sam:1-2/N_sam;%u=sin(sita)*cos(fai)��U��
v=-1:2/N_sam:1-2/N_sam;%v=sin(sita)*sin(fai)��V��
[X,Y]=meshgrid(u,v);
FF=zeros(N_sam,N_sam);%��������
lamda=1;%����

fun_x=find(Bestallarray~=0);     
%�õ��Ľ��Ϊһ������������Ԫ��λ������ֵ��ά��һ���quartered_matrix�ͣ����ǰ�
%û����Ԫ��λ��ȥ��
q_position=[real(Bestallarray(fun_x)) imag((Bestallarray(fun_x)))]; 
%�õ��Ľ��Ϊ��ά����������һ�з�ֵ���ڶ�����λ��������fun_xһ��    
%-----������δ�����Ƿ���ͼ�ļ��� ��ʽ��2���ͣ�3��ֻ��ת��Ϊ��ֱ�������������
for n=1:N_sam
    for m=1:N_sam
        if abs(v(m))<=sqrt(1-u(n)^2)% ��ѧ�Ƶ������Ա�֤���޶��ڵ�λԲ�ڲ�
           temp=0;
           for a=1:length(fun_x)%��������Ԫ�����ϵģ�����Ӧ��������Բƽ��  
               temp=temp+exp(j*2*pi*q_position(a,1)*(cos(q_position(a,2))...
                       *u(n)+sin(q_position(a,2))*v(m)));
           end
           FF(n,m)=temp+1;%����Բ��        
       else 
       end
   end
end

FF(find(FF==0))=eps; %eps�Ƿǳ�С��һ����
ff=20*log10(abs(FF)/max(max(abs(FF))));%%��һ��
bottom=-40;%���õ�ƽ̨��ƽ
ff(find(ff<=-40))=bottom;%��͵�ƽ����Ϊ-80db
%when fai=0 ---ff(m,:) ---u axis   
%when fai=90 ---ff(:,m) ---v axis  when fai=45----u=v
m=ceil(find(ff==max(max(ff)))/N_sam);%��һ��100*100�ľ������ҵ����ֵ��λ��
fai0=ff(m,:); fai90=ff(:,m);  

%-----uvͼ


figure
plot(u,fai0,'-b');
hold on
plot(v,fai90,'--r');
legend('u=0','v=0');
%ylabel('F(u,v)/dB');
%xlabel('��,��');
figure_FontSize=14;
set(get(gca,'XLabel'),'FontSize',figure_FontSize);
set(get(gca,'YLabel'),'FontSize',figure_FontSize);
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);

text(0.48,-10,'sampling number :1024','horiz','left','color','b','fontsize',7)
% text(0.5,-12,'PSLL��-19.34dB','horiz','left','color','b','fontsize',7)
text(0.48,-12,sprintf('PSLL:%0.2f',rsll),'horiz','left','color','b','fontsize',7);
text(0.76,-12,'dB','horiz','left','color','b','fontsize',7);
xlabel('u,v');
ylabel('Radiation pattern (dB)');

%-----����ͼ
figure
mesh(X,Y,ff);%��������ͼ
shading interp;
% colormap(gray);
xlabel('u=sin\theta cos ��');
ylabel('v=sin\theta sin ��');
zlabel('Radiation pattern (dB)');

%-----����ͼ
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
%-----��Ԫ�ֲ�ͼ
%---9ͬ��Բ

figure         %һ��ͼƬ����ȫ��һ��ͼƬ������ݡ�
alpha=0:pi/20:2*pi;%�Ƕ�[0,2*pi]
%Radius_edit=0.5*lamda*[1:1:aperture];%�뾶�仯
Radius_edit=Population_Init(:,1);
Radius_edit';
for n=1:circle_num+1
    R=Radius_edit(n);%�뾶
    x=R*cos(alpha);
    y=R*sin(alpha);
    hold on
    plot(x,y,'--');
end
axis equal;%ʹ����ʵ�ʾ�����ȣ�������ʾΪһ����׼��Բ�Σ�����������
%set(gca,'xlim',[-10 10],'xtick',-10:2:10);%�������
set(gca,'xlim',[-(0.5*(circle_num+4)+0.5) 0.5*(circle_num+4)+0.5]);%�������
set(gca,'ylim',[-(0.5*(circle_num+4)+0.5) 0.5*(circle_num+4)+0.5]);%ʹԲ�߽��������֮�����пհ�
figure_FontSize=14;
set(get(gca,'XLabel'),'FontSize',figure_FontSize);
set(get(gca,'YLabel'),'FontSize',figure_FontSize);
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',1);
hold on


text(2.8,5.2,sprintf('Element number:%0.0f',element_sum),'horiz','left','color','b','fontsize',7);
text(2.8,4.6,'element:','horiz','left','color','b','fontsize',7);
text(4.4,4.62,'o','horiz','left','color','b','fontsize',9);
ylabel('y(��)');
xlabel('x(��)');
%---��Ԫ�ֲ�
for n=1:element_sum
    R=real(Bestallarray(n));%�뾶
    alpha=imag(Bestallarray(n));%�Ƕ�[0,2*pi]
    x=R*cos(alpha);
    y=R*sin(alpha);
    hold on
    plot(x,y,'Marker','o');
end
axis([-6.3 6.3 -6.3 6.3])
toc


