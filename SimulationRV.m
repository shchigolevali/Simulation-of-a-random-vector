%Simulation of random variables
clc
close all
clear 

%Инициализация переменных 
N=100;
Xn=zeros(1,N);
Yn=zeros(1,N);
D=zeros(1,N);

%Задание const
c=0.66464;
b=0.52752;k=0.26041;x0=1.1294;
p_53=0.29411;
S=0.88023;S1=0.16608;
c1=0.146192;c2=0.225386;

%Моделирование Xn
for i=1:N
    Unx=rand; 
    if(Unx<=c1)
        Xn(i)=sqrt(1.27554*rand);
    end
    if((c1<Unx)&&(Unx<=c1+c2))
        Xn(i)=(2-x0)*rand+x0;
    end
    if(Unx>c1+c2)
       Unxt=rand; 
       if(Unxt<=0.4)
          Xn(i)=-log(rand)+2;
       end
       if ((0.4<Unxt)&&(Unxt<=0.8))
           Xn(i)=-log(rand*rand())+2;
       end
       if(Unxt>0.8)
           Xn(i)=-log(rand*rand*rand)+2;
       end
    end
end

%Моделирование Yn
for i=1:N
   Uny=rand();
    if (Xn(i)<=x0)&&(Uny <(2.55225*Xn(i)^(2/3)*exp(-Xn(i))))
        Yn(i)=Uny*k*Xn(i);
    end
    if (Xn(i)>x0 &&Xn(i)<=2 && Uny<(c/p_53)*Xn(i)^(5/3)*exp(-Xn(i)))
        Xn(i)=Xn(i);
        Yn(i)=Uny*p_53;
    end
    if (Xn(i)>2 && Uny<(c/b)*Xn(i)^(-1/3)) 
        Xn(i)=Xn(i);
        Yn(i)=Uny*b*Xn(i)^2*exp(-Xn(i));
    end
 
end

%Вывод графиков

var=sort(Xn);
figure(1)
ecdf(var);
hold on 
x2=0:0.01:10;
y2=gamcdf(x2,8/3,1);
plot(x,y2,'k')
hold off
grid on
legend('Эмпирическая ф.р.','Предполагаемая ф.р.')

%Проверка гипотизы по критерию Колмогорова
for i=1:N
    D(1,i)=max(abs(gamcdf(var(i),8/3,1)-(i-1)/N),abs(i/N-gamcdf(var(i),8/3,1)));
end

D_Kolmogor=max(D)*sqrt(N)
