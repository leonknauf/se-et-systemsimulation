% Ueb_LCR_vorlage.m enth�lt ist die Vorlage f�r die �bung ueb_LCR
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-21
%
% �nderung: 2018-06-21
%           Fall 0 zugef�gt.Einfaches Beispiel Sprungantwort
%           2019-05-09 Beispiel f�r eigenen Solver Runge_Kutta4sys zugef�gt
%           siehe switch in Beispiel 1
%
% siehe auch: 

%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace l�schen
 
%% System Parameter
%-----------------
R=0.2;              % Widerstand                    [Ohm]
L=1;                % Induktivit�t                  [H]
C=1;                % Kapazit�t                     [F]

%% Systembeschreibende Gr��en
%----------------------------
Tp=2*pi*sqrt(L*C);  % Periodendauer der Schwingung  [s]
Tau=L/R;            % Zeitkonstante der D�mpfung    [s]

%% Zeitvektor
dt=Tp/100;          % Abtastzeit                    [s]
tmax=8*Tau;         % Simulationszeit               [s]

t=0:dt:tmax;        % Zeitvektor                    [s]
Nt=length(t);       % L�nge des Zeitvektors         [-]

%% St�rfunktion
U0=5;              % Versorgungsspannung           [V]
u_in=U0;

%% Anfangsbedingung
i0=5;               % Anfangsstrom                   [A]    
u_c0=0;             % Anfangsspannung am Kondensator [V]
y0=[i0 u_c0]';

uc=zeros(1,Nt);     % Spannungswerte am Kondensator
i=zeros(1,Nt);      % Stromwerte

uc(1)=u_c0;         % Erster Wert ist gleich Spannungswert
i(1)=i0;            % 
%% Berechnung der DGLs mit Euler
for k=2:Nt
   uc(k)=uc(k-1)+1/C*i(k-1)*dt;
   i(k)=i(k-1)+(-R/L*i(k-1)-1/L*uc(k-1)+1/L*u_in)*dt;
end 
%% Ergebnis darstellen
figure
    plot(t,U0*ones(1,Nt),'k',t,uc,'b',t,i,'r')
    title(' Beispiel linearer Reihenschwingkreis. Eingangsspannung')
    xlabel(' t [s]')
    ylabel(' u [V]; i [A]')
    grid
    legend('Uo', 'u_c', 'i')
