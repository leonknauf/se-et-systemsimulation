% Ueb_LCR_vorlage.m enthält ist die Vorlage für die Übung ueb_LCR
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-21
%
% Änderung: 2018-06-21
%           Fall 0 zugefügt.Einfaches Beispiel Sprungantwort
%           2019-05-09 Beispiel für eigenen Solver Runge_Kutta4sys zugefügt
%           siehe switch in Beispiel 1
%
% siehe auch: 

%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen
 
%% System Parameter
%-----------------
R=0*0.2;              % Widerstand                    [Ohm]
L=1;                % Induktivität                  [H]
C=1;                % Kapazität                     [F]

%% Systembeschreibende Größen
%----------------------------
Tp=2*pi*sqrt(L*C);  % Periodendauer der Schwingung  [s]
%Tau=L/R;            % Zeitkonstante der Dämpfung    [s]

%% Zeitvektor
dt=Tp/100;          % Abtastzeit                    [s]
tmax=4*Tp;%8*Tau;         % Simulationszeit               [s]

t=0:dt:tmax;        % Zeitvektor                    [s]
Nt=length(t);       % Länge des Zeitvektors         [-]

%% Störfunktion
U0=5;              % Versorgungsspannung           [V]
u_in=U0;

%% Anfangsbedingung
i0=5;               % Anfangsstrom                   [A]    
u_c0=0;             % Anfangsspannung am Kondensator [V]
y0=[i0 u_c0]';

%% DGL Aufruf mit ode45

[~,y] = ode45(@dgl_RCL,t,y0,[],L,R,C,U0);

i=y(:,1);
uc=y(:,2);

%% Ergebnis darstellen
figure
    plot(t,U0*ones(1,Nt),'k',t,uc,'b',t,i,'r')
    title(' Beispiel linearer Reihenschwingkreis. Eingangsspannung')
    xlabel(' t [s]')
    ylabel(' u [V]; i [A]')
    grid
    legend('Uo', 'u_c', 'i')


function Yp = dgl_RCL(~,y,L,R,C,U_in)
    auswahl = 2;

    switch (auswahl)
        case 1
            i=y(1);
            uc=y(2);
        
            di_dt=-R/L*i-1/L*uc+1/L*U_in;
            duc_dt=1/C*i;
        
            Yp=[di_dt duc_dt]';

        case 2

            i=y(1);
            uc=y(2);

            A=[-R/L -1/L; 1/C 0];
            B=[1/L; 0];

            dx_dt = A * [i; uc] + B * U_in;

            Yp=dx_dt;

    end
end
