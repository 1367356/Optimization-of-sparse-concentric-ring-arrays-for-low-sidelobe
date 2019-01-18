a=[0.76          1.36            2.09         2.99         3.78         4.70]
b=[9/9       17/17    25/26  31/37  26/47    33/59]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[xData, yData] = prepareCurveData( a, b );
figure( 'Name', 'fitting function' );

%%%%%%%%%%%%%%%%%%%%���Ժ����Ǻ������Linear%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set up fittype and options.
ft = fittype( {'(sin(x-pi))', '((x-10)^2)', '1'}, 'independent', 'x', 'dependent', 'y', 'coefficients', {'a', 'b', 'c'} );
[fitresult, gof] = fit( xData, yData, ft );
h = plot( fitresult,'y' );
text(1.38,1.15,'line1','fontsize',7,'Color','y');
annotation('arrow',[0.31,0.31],[0.86,0.74],'LineStyle','-','color','y','LineWidth',1)
hold on

%%%%%%%%%%%%%%%%%%%��˹��Ϻ���gauss%%%%%%%%%%%%%%%%%%%%%%%%%%
ft = fittype( 'gauss1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0];
opts.StartPoint = [1 1.36 1.88600831143393];
% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
% Plot fit with data.
h = plot( fitresult,'b');
text(1.65,1.1,'line2','fontsize',7,'Color','b');
annotation('arrow',[0.35,0.35],[0.81,0.69],'LineStyle','-','color','b','LineWidth',1)
% % Label axes
hold on
%%%%%%%%%%%%%%%%%%%%���Ǻ������sin%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ft = fittype( 'sin1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf 0 -Inf];
opts.StartPoint = [1.07134961330033 0.797358541520252 -0.325312556985224];
% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
% Plot fit with data.
h = plot( fitresult,'k' );
annotation('arrow',[0.388,0.388],[0.78,0.652],'LineStyle','-','color','k','LineWidth',1)
text(1.88,1.07,'line3','fontsize',7,'Color','k');
hold on
%%%%%%%%%%%%%%%%%%%%�������power%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ft = fittype( 'power1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.922200973525415 -0.171182750755102];
% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
% Plot fit with data.
h = plot( fitresult,'g' );
text(0.6,0.9,'line4','fontsize',7,'Color','g');
annotation('arrow',[0.213,0.32],[0.615,0.615],'LineStyle','-','color','g','LineWidth',1)
hold on
%%%%%%%%%%%%%%%%%%%%rato���rato%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ft = fittype( 'rat01' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.232051217436923 0.919162820955473];
% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
% Plot fit with data.
h = plot( fitresult,'c');
text(0.8,0.83,'line5','fontsize',7,'Color','c');
annotation('arrow',[0.245,0.44],[0.545,0.545],'LineStyle','-','color','c','LineWidth',1)
hold on
%%%%%%%%%%%%%%%%%%%%һ���������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ft = fittype( 'poly1' );
% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft );
% Plot fit with data.
h = plot( fitresult,'r');
text(1.3,0.77,'line6','fontsize',7,'Color','r');
annotation('arrow',[0.323,0.547],[0.485,0.485],'LineStyle','-','color','r','LineWidth',1)
hold on
%%%%%%%%%%%%%%%%%%%��������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(x,y,'bo','MarkerFaceColor','b');
hold on
% legend(  'b vs. a' );
axis([0.3 5.3 0.4 1.2]);  %ָ�����귶Χ
legend('line1: Linear function model','line2: Gauss function model','line3: Sine function model','line4: Power function model','line5: Rational function model','line6: polynomial funtion model','Fitting data') %���������ó�����Ҫ������
hold on
ylabel('\itP_n','FontSize',10.5);
xlabel('\itr_n(��)','FontSize',10.5);
% xlable('r_n(\lamda)')
% ylable('P_n')