close all;
clearvars;

punkte=[-5 0 5 -5;  0 sqrt(75) 0 0];
tiefe=7;
[x,y] = Koch_Flocke_fun(punkte, tiefe);

figure;
fill(x,y,'b');
axis('equal','off')

length = length_koch_fun(x,y);
"Length: "+length