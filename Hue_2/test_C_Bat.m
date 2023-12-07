close all;  % Alle plots schliessen
clearvars;  % workspace löschen

num_parameters = 2;


f = figure;
f.Position = [360 140 1200 800];
f.NumberTitle = 'off';
f.Name = 'Hausübung 2';

for para = 1:num_parameters
    switch para
        case 1
            C_Last = 6;
            R_Last = 100000;
            U_Last_0 = 0;
        
        case 2
            C_Last = 20;
            R_Last = 1000;
            U_Last_0 = 0;
    end
    
    C_Bat = 20;
    R_Bat = 100;
    U_Bat_0 = 1;

    R_P = (R_Last * R_Bat) / (R_Bat + R_Last);
    Tau_Bat = C_Bat * R_Bat;
    Tau_C1 = C_Last * R_Bat;
    Tau_C2 = C_Last * R_P;
    
    
    tmax=30*Tau_Bat;         % Simulationszeit               [s]
    dt=tmax/800;          % Abtastzeit                    [s]
    
    t=0:dt:tmax;        % Zeitvektor                    [s]
    Nt=length(t);       % Länge des Zeitvektors         [-]
    
    % Für die ode45 werden die Anfangswerte als Spaltenvektor benötigt
    y0 = [U_Bat_0 U_Last_0]';
    
    
    [~,y] = ode45(@dgl_C_Bat,t,y0,[],Tau_Bat, Tau_C1, Tau_C2);	
    
    U_Bat =y(:,1);  % Strom [A]
    U_Last=y(:,2);  % Spannung am Kondensator[V]
    t_in_h = (t/3600);

    p0 = [0.8 -1/500000 -0.8 -1/1000];
    p=fminsearch(@LadeFkt_f_min_fun,p0,[],t,y(:,2)');
    c1 = p(1);
    c2 = p(2);
    c3 = p(3);
    c4 = p(4);
    U_Last_est = c1 * exp(c2*t)+c3*exp(c4*t);
       
    plot1 = subplot(num_parameters*2,1,(para-1)*2 + 1);  
    plot(t_in_h,U_Bat,'b',t_in_h,U_Last,'r');
    title(['Kondensator als Batterie Paramterwerte ' num2str(para) ':']);
    xlabel('t [h]'); 
    ylabel('U_B [V]; U_L [V]');
    grid;
    legend('U_B', 'U_L');

    plot2 = subplot(num_parameters*2,1,(para)*2);  
    plot(t_in_h,U_Last_est,'g',t_in_h(1:15:end),U_Last(1:15:end),'r*');
    title('Resultierende Funktion durch fminsearch:');
    xlabel('t [h]'); 
    ylabel('U_L_,_e_s_t [V]; U_L [V]');
    legend('U_L_,_e_s_t', 'U_L');


    pos1 = get(plot1,'Position');
    pos2 = get(plot2,'Position');
    if para<=num_parameters/2
        pos1(2) = pos1(2) + 0.03;
        pos2(2) = pos2(2) + 0.03;
    else
        pos1(2) = pos1(2) - 0.03;
        pos2(2) = pos2(2) - 0.03;
    end
    set (plot1, 'Position', pos1)
    set (plot2, 'Position', pos2)
    annotation("line",[0.05 0.95],[0.506 0.506]);
end

% figure
% for para = 1:num_parameters
%     subplot(num_parameters*2,1,para);  
%     plot(t_in_h(:,para),U_Bat(:,para),'b',t_in_h(:,para),U_Last(:,para),'r',t_in_h(:,para),U_Last_est(:,para),'g');
%     title(['Hue2: Kondensator als Batterie (' num2str(para) ')']);
%     xlabel('t [h]'); 
%     ylabel('U_B_a_t [V]; U_L_a_s_t [V]');
%     grid;
%     legend('U_B_a_t', 'U_L_a_s_t');
% end

function Yp = dgl_C_Bat(~,y,Tau_Bat, Tau_C1, Tau_C2)

    GleichungenMatrix='Gleichungen';
    % GleichungenMatrix='Matrix';

    switch GleichungenMatrix

        case 'Gleichungen'
        %------------------------------------------    
            U_Bat=y(1);    % Strom                 [A]
            U_Last=y(2);   % Kondensatorspannung   [V]
     
            % Differentialgleichssystem
            dUB_dt=1/Tau_Bat * (U_Last - U_Bat);
            dUL_dt=U_Bat/Tau_C1 - U_Last/Tau_C2;

            % Rückgabewerte    
            Yp=[dUB_dt
                dUL_dt]; 
        %-----------------------------------------

        case 'Matrix'
        %-----------------------------------------
            A=[-1/Tau_Bat   1/Tau_Bat;
                1/Tau_C1    -1/Tau_C2];

            % DGL-System
            Yp=A*y;

    end %switch

end % function

function y=LadeFkt_f_min_fun(p,t_mess,U_Last_mess)
    c1 = p(1);
    c2 = p(2);
    c3 = p(3);
    c4 = p(4);

    U_Last_est = c1 * exp(c2*t_mess)+c3*exp(c4*t_mess);

    y=sum((U_Last_est-U_Last_mess).^2);
end
