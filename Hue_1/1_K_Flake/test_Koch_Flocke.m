
% Noch geöffnete Plots schließen
close all;

% Variablenspeicher leeren
clearvars;

% Startpunkte definieren
punkte=[-5 0 5 -5;  0 sqrt(75) 0 0];

% punkte=[-5 -5 5 5 -5;  0 10 10 0 0];

% Maximale Tiefe definieren
tiefe=7;

% [x,y] = K_flake_fun(punkte, 1);

% Punkte der Kochschen Flocke berechnen
[x,y] = Koch_Flocke_fun(punkte, tiefe);

% Länge berechnen und ausgeben
length = length_koch_fun(x,y);
"Length: "+length

% Plot generieren
figure;

% Punkte darstellen
fill(x,y,'b');
% scatter(x,y,0.1);

% Achsen konfigurieren
axis('equal','off');

