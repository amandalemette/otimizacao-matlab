clear all
% 0.3 * X1 + 0.6 * X2 <=2000
% 0.2 * X1 + 0.05 * X2 <=500
% 0.4* X1 + 0.25* X2 <=1500
cg = @(x1) (2000 - 0.3*x1)/0.6
cl = @(x1) (500 - 0.2*x1)/0.05
cc = @(x1) (1500 - 0.4*x1)/0.25

x=linspace(0,10000,10000)

plot(x,cg(x),'r-')
hold on
plot(x,cl(x),'b-')
plot(x,cc(x),'g-')
ylim([0 10000])
xlabel('X1');
ylabel('X2');

Aeq=[];
beq=[];
A=[0.3 0.6; 0.2 0.05; 0.4 0.25];
b=[2000 500 1500];
ub=[2500 3330];
lb=[0 0];
x0=[500 600];
%[x, fval]=fmincon(@Fobj,x0,A,b,Aeq,beq,lb,ub);
options=optimoptions('particleswarm','Display','iter','SwarmSize',1000,'MaxIter',10000);
nvars=2;
[x2, fval2, exitflag,output]=particleswarm(@Fobj,nvars,lb,ub,options);

L=-fval2;
plot(x(1),x(2),'ko')
plot(x2(1),x2(2),'co')
legend('gasolina','lubrificante','�leo','Ponto �timo MinCon', 'Ponto �timo Warm')
function F=Fobj(x)
  Venda=x(1)*0.3*35+x(1)*0.2*55+x(1)*0.4*20+x(2)*0.6*35+x(2)*55*0.05+x(2)*0.25*20;
  Custo=x(1)*15+x(2)*18+x(1)*0.2+x(2)*0.8;
  L=Venda-Custo;
  F=-L;
  if (x(2)>(2000 - 0.3*x(1))/0.6) || (x(1) > (500-0.05*x(2))/0.2)
      F = 1e10;
  end
      
end
