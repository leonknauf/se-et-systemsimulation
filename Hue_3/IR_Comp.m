% m-file: IR_Comp.m
%
% Erklärung
%
% Dieses m-File berechnet die Motordrehzahl aus den angegebenen
% Systemvariablen für unterschiedlichen Kompensationsfaktoren
% 
% Input: Motorparameter, Simulationsparameter, Systemparameter, 
%        Simulationszeit, Anfangsbedingung
%           
% Output: Grafische Darstellung der Motordrehzahl für verschiedene
%         Kompensationfaktoren          
%
% Beispiel: 
%
% Autor:	Leon Knauf
%
% Datum:    08.01.2024
%
% Änderung: 
%
% Benötigte eigene externe functions: keine
%
% siehe auch: 
%
%--------------------------------------------------------------------------  

%% Anwendung initialisieren

close all;  % Schließen von offenen Plots
clearvars;  % Variablenspeicher leeren


%% Grafische Ausgabe initialisieren

f = figure; % Generieren eines Ausgabefensters 
f.Position = [360 340 1200 600]; % Ändern der Fenstergröße
f.NumberTitle = 'off'; % Entfernen von 'Figure 1' aus dem Fenstertitel
f.Name = 'Hausübung 3'; % Anpassen des Fenstertitels


%% Systemparameter definieren

Ra=10;                                          % Ankerwiderstand [Ohm]
Psi=15e-3;                                      % Verketteter Fluss [Vs]
La=10e-3;                                       % Ankerinduktivität [H]
J=5e-7;                                         % Massenträgheitsmoment [kgm²]
k_var=[0 0.5 sqrt(2)/2 0.8 0.9 0.97 1.0]*Ra;    % Variationswerte für die Kompensation [Ohm]

Ta=La/Ra;                                       % Zeitkonstante Tau [s]


%% Eingangsparameter definieren

Ua_0=5;         % Spannung für die Solldrehzahl [V]
M_Last=4e-3;	% Mechanische Last [Nm]
dM_Last_dt=0;   % Zeitabhängige Laständerung [Nm/s]

%% Simulationszeit festlegen

tmax=Ta*111;                    % Simulationsdauer [s]
anz_werte=400;                  % Anzahl Stützstellen
t=linspace(0,tmax,anz_werte);   % Zeitvektor [s]


%% Anfangsbedingungen definieren

y0=[0 0]'; % Anfangsbedingung in einer Spalten-Matrix


%% Ausgabevariable initialisieren

n=zeros(anz_werte,length(k_var)); % Matrix für die Drehzahlwerte


%% Aufruf ode45 für jede Variation

for i=1:1:length(k_var)
    [~, y]=ode45(@DGL_Motor, t, y0, [], Ua_0, Ra, La, k_var(i), Psi, J, M_Last, dM_Last_dt);   % ode45 Aufruf

    % Berechnen der Drehzahl
    n(:,i)=y(:,2)*60/(2*pi); % Drehzahl [1/min]
end


%% Grafische Ausgabe

t=t*1000;                                                       % Zeitvektor in ms umwandeln
plot(t,n)                                                       % Funktionen n(t) in ms darstellen
xlabel('t [ms]')                                                % Beschriftung X-Achse
ylabel('n [U/min]')                                             % Beschriftung Y-Achse
title('Drehzahlverlauf des Motors')                             % Titel des Plots anpassen
legend('0', '0.5', '0.707', '0.8', '0.9', '0.97', '1.0');       % Legende einfügen
grid;                                                           % Hintergrundraster aktivieren


%% function DGL_Motor

function Yp=DGL_Motor(~,y, Ua_0, Ra, La, k, Psi, J, M_Last, dM_last_dt)

    % Berechnung der Faktoren
    k1 = (Ra-k)/La;                                                 % Faktor k1
    k2 = Psi^2/(La*J);                                              % Faktor k2
    k3 = (Psi/(La*J))*Ua_0-(1/J*dM_last_dt+(Ra-k)/(La*J)*M_Last);   % Faktor k3

    % Definition der Matrizen
    A=[-k1 -k2; 1 0];
    b=[k3; 0];

    % Angabe der DGL in Matrixform
    Yp=A*y+b;

end