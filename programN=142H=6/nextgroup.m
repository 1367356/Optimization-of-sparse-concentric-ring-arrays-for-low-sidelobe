function [Population_next]=nextgroup(Population_Init,Rsll_it,group_num,circle_num,L,element_space,circle_i)

%��������
%Population_Init ���� 
%Rsll_it�԰��ƽ����
%group_num��Ⱥ��
%circle_numԲ������
%genetic_i  �Ŵ�����
%element_space  ��С��Ԫ����
%L  �׾���С
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Ԥ����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
basic_distance=element_space:element_space:circle_num*element_space;
for i=1:group_num
    for j=2:circle_num+1
        Population_Init(j,i)=Population_Init(j,i)-basic_distance(j-1);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

trunc=0.5;%�ضϷ�ֵ������ֵ��
crossover_probability=0.20;%������ʣ�����ֵ��
mutation_probability=0.02;%������ʿ��ǵ�һ������ֵ������Ĵ�Χ�Ķ�������ֵ������ȡСֵ

retain_gene_num=fix(group_num*trunc);%fix()����ȡ������
%����Ļ������
crossover_gene_num=fix((circle_num+1)*crossover_probability);
%����Ļ������
mutation_gene_num=ceil((circle_num+1)*mutation_probability);%���������ȡ��,ȥβ��1��������ʽ�С

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����������Ŵ�%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----��̭һ����Ⱥ
%tem_new=size(InMatrix);%ȫ���С
%N=tem(1);group=tem(2);
[Y,I]=sort(Rsll_it);%���ಢ��ȡ������Ϣ,��Rsll��С��������,��������Y�У�IΪ������Ԫ����ԭRsll�е�λ��
for m=1:retain_gene_num
   Population_next1(:,m)=Population_Init(:,I(m));%�������ʱ�����Ⱥ�����,���������ĸ��塣
end
Population_next=[Population_next1 Population_next1];%�������ʱ�����Ⱥ�����,����Ӧ�ȸߵĴ�������Ӧ�ȵ͵ģ�������Ⱥ�İ뾶��ϳɵľ���
%-----��Ⱥ����
%cross befin����������Ⱥ����������õ�һ������Ⱥ
Cross_Group=Population_next;

half_group_num=group_num/2;
%�������棬n_retainΪ2�ı���  ,Ӧ�ý���һ����н�����죬ǰ������š������Ų������ɸ�����ֵ.
    %�������
% index1=randperm(circle_num);%randperm������������1��n����
% index=[1 index1+1];%index=[1,index1(1)+1,index1(2)+1,....,index1(length(index1))+1]
% index_group_num=randperm(group_num/2);
for tem1=2:half_group_num%crossover_gene_num���ڸ����������û����������Ҫ����ĸ���
    index1=randperm(circle_num);%randperm������������1��n����
    index=[1 index1+1];%index=[1,index1(1)+1,index1(2)+1,....,index1(length(index1))+1]
    index_group_num=randperm(group_num/2);
    
    rand_index1=index_group_num(tem1);
    verify_index=mod(tem1+fix(rand()*half_group_num),group_num/2);
    if verify_index==0
        rand_index_2=tem1-1;
    else
        rand_index_2=index_group_num(verify_index);
    end
%     unit1=Cross_Group(rand_index1);
%     unit2=Cross_Group(rand_index_2)       
	for i=1:circle_num+1;
        if  index(i)==1 || index(i)==circle_num+1
            continue
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Ԥ����֮��Ľ������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        if ( Cross_Group(index(i),half_group_num+rand_index1)-Cross_Group(index(i)+1,half_group_num+rand_index_2))<0 &&...
                ( Cross_Group(index(i),half_group_num+rand_index1)-Cross_Group(index(i)-1,half_group_num+rand_index_2))>0 &&...           
                ( Cross_Group(index(i),half_group_num+rand_index_2)-Cross_Group(index(i)+1,half_group_num+rand_index1))<0 &&...
                ( Cross_Group(index(i),half_group_num+rand_index_2)-Cross_Group(index(i)-1,half_group_num+rand_index1))>0
            
            tem2=Cross_Group(index(i),half_group_num+rand_index1);%��ȡ����Ļ���,
            Cross_Group(index(i),half_group_num+rand_index1)=Cross_Group(index(i),half_group_num+rand_index_2);%����
            Cross_Group(index(i),half_group_num+rand_index_2)=tem2;%����,
            break 
        end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%û��Ԥ����Ľ������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
%         if abs( Cross_Group(index(i),half_group_num+rand_index1)-Cross_Group(index(i)+1,half_group_num+rand_index_2))>=0.5 &&...
%                 abs( Cross_Group(index(i),half_group_num+rand_index1)-Cross_Group(index(i)-1,half_group_num+rand_index_2))>=0.5 &&...           
%                 abs( Cross_Group(index(i),half_group_num+rand_index_2)-Cross_Group(index(i)+1,half_group_num+rand_index1))>=0.5 &&...
%                     abs( Cross_Group(index(i),half_group_num+rand_index_2)-Cross_Group(index(i)-1,half_group_num+rand_index1))>=0.5
                %���彻��͹�����죬����Ⱥ��ѡ���������壨����1������Ⱥ�еĽǱ�ֵ��half_group_num+rand_index1��������2�ĽǱ�ֵ��half_group_num+rand_index_2
                %����������Ӻ�һ����Ⱥ��ѡ����
                %ѡ���index(i)�Ż���
                %�жϸ���1��index(i)�Ż��������2�е�index(i)+1��index(i)-1��������ľ����Ƿ������Ԫ��С���롣
                %ͬ���жϸ���2��index(i)�Ż��������1�е�index(i)+1��index(i)-1��������ľ����Ƿ������Ԫ��С���롣
                %������㣬����н���任��   
% 
%                   tem2=Cross_Group(index(i),half_group_num+rand_index1);%��ȡ����Ļ���,
%                   Cross_Group(index(i),half_group_num+rand_index1)=Cross_Group(index(i),half_group_num+rand_index_2);%����
%                   Cross_Group(index(i),half_group_num+rand_index_2)=tem2;%����,
%                     break  



%         end
    end

end

%-----��Ⱥ����
%muate befin����������Ⱥ����������õ���һ������Ⱥ
%Muate_Group=Retain_Group;
Muate_Group=Cross_Group;
%���������ע��n=1�����в�������Ϊn=1Ϊ��һ�����Ž⣬Ҫ���������ܽ��иı�

for n=2:group_num;%�������ЩԲ�뾶֮��ľ���С��0.5����������
%NewSpar_groupup(fix(rc(1)/2),n)=unifrnd(0,residual_space);
    %t=unifrnd(0,5,mutation_gene_num+1,1);
   t=(L/2)*rand(mutation_gene_num+1,1);
    
   index1=randperm(circle_num);%randperm������������1��n����
   index=[1 index1+1];
   for i=1:circle_num+1
        if  index(i)==1 || index(i)==circle_num+1
            continue
        end
%         if abs(Muate_Group(index(i)+1,n)-Muate_Group(index(i),n))>=0.5 && abs(Muate_Group(index(i)-1,n)-Muate_Group(index(i),n))>=0.5
        Muate_Group(index(i),n)=Muate_Group(index(i)-1,n)+rand()*(Muate_Group(index(i)+1,n)-Muate_Group(index(i)-1,n));
        break
%         end
   end   
%�����µ��������������������Ϊn_mutation��
end
%��4�������Ļ�������滻

%�����µ��������������������Ϊn_mutation��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�Ŵ�����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:group_num
    for j=2:circle_num+1
        Muate_Group(j,i)=Muate_Group(j,i)+basic_distance(j-1);
    end
end
%----�õ���һ����Ⱥ�����
%New_Group_Rand=cat(2,Muate_Group,Cross_Group);%2ά��������
Population_next=Muate_Group;%����