clear all
clc

r1 = @(x1) (2000 - 0.3*x1)/0.6;
r2 = @(x1) (500 -0.2*x1)/0.05;
r3 = @(x1) (1500 - 0.4*x1)/0.25;

x1 = linspace(0,80000,10000);

for i = 1:length(x1)
   x2_1(i) = r1(x1(i));
   x2_2(i) = r2(x1(i));
   x2_3(i) = r3(x1(i));
end

figure(1)
plot(x1,x2_1,'r-','LineWidth',4);
hold on
plot(x1,x2_2,'b--','LineWidth',4);
plot(x1,x2_3,'g-.','LineWidth',4);
ylim([0 2e4])


x0 = [1000, 600]; % chute inicial (x1 e x2)
A = [0.3, 0.6; 0.2,0.05;0.4,0.25];
b = [2000;500;1500];
Aeq = [];
beq = [];
lb = [0,0];
ub = [];
disp('Fobj inicial:')
disp(Fobj(x0))
x = fmincon(@Fobj,x0,A,b,Aeq,beq,lb,ub);
disp('Fobj final:')
disp(Fobj(x))

plot(x(1),x(2),'ro','MarkerSize',10,'MarkerFaceColor','k');
xlabel('x_1','FontSize',18)
ylabel('x_2','FontSize',18)
print('-dtiff','-r100','otm.tiff') % -djpg, -dpng
hold off

function f = Fobj(x)
    f = 35*(0.3*x(1)+0.6*x(2))+55*(0.2*x(1)+0.05*x(2))+20*(0.4*x(1)+0.25*x(2))-...
        15*x(1)-18*x(2)-0.2*x(1)-0.8*x(2);
    f= - f;
end







