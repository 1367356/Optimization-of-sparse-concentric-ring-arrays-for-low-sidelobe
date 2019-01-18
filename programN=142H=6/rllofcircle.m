%--------------------------------������----------------------------------%
%�Ӻ�������Բ����ͼ����ֵ��ƽ���㺯��
%�������ܣ�����Բ��ķ���ͼ�Լ���ֵ�԰��ƽֵ

function rsll=rllofcircle(quartered_matrix)
%----��������
%quartered_matrixԲ����Ԫλ��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%������������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N_sam=100;  %��������
u=-1:2/N_sam:1-2/N_sam;%u=sin(sita)*cos(fai)��U��
v=-1:2/N_sam:1-2/N_sam;%v=sin(sita)*sin(fai)��V��
FF=zeros(N_sam,N_sam);%��������


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���㷽��ͼ����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fun_x=find(quartered_matrix~=0);     
%�õ��Ľ��Ϊһ������������Ԫ��λ������ֵ��ά��һ���quartered_matrix�ͣ����ǰ�
%û����Ԫ��λ��ȥ��
q_position=[real(quartered_matrix(fun_x)) imag((quartered_matrix(fun_x)))]; 
%�õ��Ľ��Ϊ��ά����������һ�з�ֵ���ڶ�����λ��������fun_xһ��  

%-----������δ�����Ƿ���ͼ�ļ��� ��ʽ��2���ͣ�3��ֻ��ת��Ϊ��ֱ�������������
for n=1:N_sam
    for m=1:N_sam
        if abs(v(m))<=sqrt(1-u(n)^2)% ��ѧ�Ƶ������Ա�֤���޶��ڵ�λԲ�ڲ�,   u(n)^2+v(m)^2<=1,��������u=sin(sita)*cos(fai),v=sin(sita)*sin(fai)�ɵá�
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�����԰��ƽ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----���²����ǹ�����
FF(find(FF==0))=eps; %eps�Ƿǳ�С��һ����
ff=20*log10(abs(FF)/max(max(abs(FF))));%%��һ��
bottom=-40;%���õ�ƽ̨��ƽ
ff(find(ff<=-40))=bottom;%��͵�ƽ����Ϊ-40db
%when fai=0 ---ff(m,:) ---u axis   
%when fai=90 ---ff(:,m) ---v axis  when fai=45----u=v
m=ceil(find(ff==max(max(ff)))/N_sam);%��һ��100*100�ľ������ҵ����ֵ��λ��
%������ֵ�кܶ����ȡ���е�һ��
fai0=ff(m,:); fai90=ff(:,m);           
%m��ȡֵ��ΧΪ1��100֮���������ȡ��m���ڵ��к��У������������ڵ��к���
%for t=1:N_sam 
%    fai45(t)=ff(t,t);
%end
%if (m<100)&&(m>1)
   tu_up=0; 
 while (fai0(m+tu_up)>=fai0(m+tu_up+1))%Ҫ�г�U����� ����
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
while (fai90(m+tv_up)>=fai90(m+tv_up+1))%Ҫ�г�V����� ����
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
ff_overall(m-tv_down:m+tv_up,m-tu_down:m+tu_up)=bottom;%ȥ������ 
%�������޶�Ϊ��Сֵ�����������޶��ĺ��񲻽�������������
rsll=max(max(ff_overall));                           %�õ�����԰��ƽ
