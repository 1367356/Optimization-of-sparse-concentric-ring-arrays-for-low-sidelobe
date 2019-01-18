function [Population_next]=nextgroup(Population_Init,Rsll_it,group_num,circle_num,L,element_space,circle_i)

%参数意义
%Population_Init 父代 
%Rsll_it旁瓣电平向量
%group_num种群数
%circle_num圆环个数
%genetic_i  遗传代数
%element_space  最小阵元距离
%L  孔径大小
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%预处理%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
basic_distance=element_space:element_space:circle_num*element_space;
for i=1:group_num
    for j=2:circle_num+1
        Population_Init(j,i)=Population_Init(j,i)-basic_distance(j-1);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

trunc=0.5;%截断阀值（经验值）
crossover_probability=0.20;%交叉概率（经验值）
mutation_probability=0.02;%变异概率考虑到一个变异值对整体的大范围改动，变异值考虑先取小值

retain_gene_num=fix(group_num*trunc);%fix()向零取整函数
%交叉的基因个数
crossover_gene_num=fix((circle_num+1)*crossover_probability);
%变异的基因个数
mutation_gene_num=ceil((circle_num+1)*mutation_probability);%向正无穷方向取整,去尾进1，变异概率较小

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%随机数矩阵遗传%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----淘汰一半种群
%tem_new=size(InMatrix);%全阵大小
%N=tem(1);group=tem(2);
[Y,I]=sort(Rsll_it);%分类并提取分类信息,将Rsll从小到大排序,排序结果在Y中，I为排序后个元素在原Rsll中的位置
for m=1:retain_gene_num
   Population_next1(:,m)=Population_Init(:,I(m));%按保留率保留种群随机数,留下优良的个体。
end
Population_next=[Population_next1 Population_next1];%按保留率保留种群随机数,用适应度高的代替是适应度低的，这是种群的半径组合成的矩阵
%-----种群交叉
%cross befin，保留的种群做交叉操作得到一半新种群
Cross_Group=Population_next;

half_group_num=group_num/2;
%两两交叉，n_retain为2的倍数  ,应该将后一半进行交叉变异，前面的留着。这样才不会生成更坏的值.
    %交叉操作
% index1=randperm(circle_num);%randperm生成随机排序的1：n向量
% index=[1 index1+1];%index=[1,index1(1)+1,index1(2)+1,....,index1(length(index1))+1]
% index_group_num=randperm(group_num/2);
for tem1=2:half_group_num%crossover_gene_num大于个体数所以用基因个数，需要交叉的个数
    index1=randperm(circle_num);%randperm生成随机排序的1：n向量
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%预处理之后的交叉操作%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        if ( Cross_Group(index(i),half_group_num+rand_index1)-Cross_Group(index(i)+1,half_group_num+rand_index_2))<0 &&...
                ( Cross_Group(index(i),half_group_num+rand_index1)-Cross_Group(index(i)-1,half_group_num+rand_index_2))>0 &&...           
                ( Cross_Group(index(i),half_group_num+rand_index_2)-Cross_Group(index(i)+1,half_group_num+rand_index1))<0 &&...
                ( Cross_Group(index(i),half_group_num+rand_index_2)-Cross_Group(index(i)-1,half_group_num+rand_index1))>0
            
            tem2=Cross_Group(index(i),half_group_num+rand_index1);%提取随机的基因,
            Cross_Group(index(i),half_group_num+rand_index1)=Cross_Group(index(i),half_group_num+rand_index_2);%交叉
            Cross_Group(index(i),half_group_num+rand_index_2)=tem2;%交叉,
            break 
        end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%没有预处理的交叉操作%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
%         if abs( Cross_Group(index(i),half_group_num+rand_index1)-Cross_Group(index(i)+1,half_group_num+rand_index_2))>=0.5 &&...
%                 abs( Cross_Group(index(i),half_group_num+rand_index1)-Cross_Group(index(i)-1,half_group_num+rand_index_2))>=0.5 &&...           
%                 abs( Cross_Group(index(i),half_group_num+rand_index_2)-Cross_Group(index(i)+1,half_group_num+rand_index1))>=0.5 &&...
%                     abs( Cross_Group(index(i),half_group_num+rand_index_2)-Cross_Group(index(i)-1,half_group_num+rand_index1))>=0.5
                %广义交叉和广义变异，从种群中选择两个个体（个体1的在种群中的角标值）half_group_num+rand_index1，（个体2的角标值）half_group_num+rand_index_2
                %这两个个体从后一半种群中选出。
                %选择第index(i)号基因，
                %判断个体1第index(i)号基因与个体2中第index(i)+1，index(i)-1两个基因的距离是否大于阵元最小距离。
                %同理，判断个体2第index(i)号基因与个体1中第index(i)+1，index(i)-1两个基因的距离是否大于阵元最小距离。
                %如果满足，则进行交叉变换。   
% 
%                   tem2=Cross_Group(index(i),half_group_num+rand_index1);%提取随机的基因,
%                   Cross_Group(index(i),half_group_num+rand_index1)=Cross_Group(index(i),half_group_num+rand_index_2);%交叉
%                   Cross_Group(index(i),half_group_num+rand_index_2)=tem2;%交叉,
%                     break  



%         end
    end

end

%-----种群变异
%muate befin，保留的种群做变异操作得到另一半新种群
%Muate_Group=Retain_Group;
Muate_Group=Cross_Group;
%变异操作，注意n=1不进行操作，因为n=1为上一代最优解，要保留，不能进行改变

for n=2:group_num;%变异后有些圆半径之间的距离小于0.5？？？？、
%NewSpar_groupup(fix(rc(1)/2),n)=unifrnd(0,residual_space);
    %t=unifrnd(0,5,mutation_gene_num+1,1);
   t=(L/2)*rand(mutation_gene_num+1,1);
    
   index1=randperm(circle_num);%randperm生成随机排序的1：n向量
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
%产生新的随机数，这里变异基因数为n_mutation个
end
%将4个连续的基因进行替换

%产生新的随机数，这里变异基因数为n_mutation个
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%遗传后处理%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:group_num
    for j=2:circle_num+1
        Muate_Group(j,i)=Muate_Group(j,i)+basic_distance(j-1);
    end
end
%----得到新一代种群随机数
%New_Group_Rand=cat(2,Muate_Group,Cross_Group);%2维横向整理
Population_next=Muate_Group;%分类