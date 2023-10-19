close all;
clearvars;

t_Mess = 1:100;
g = 9.81;
v_schall = 300;
max_iter = 400;

s_exakt = zeros(length(t_Mess),1);
s = zeros(length(t_Mess), max_iter);

for i=1:length(t_Mess)
    s_exakt(i) = v_schall/g * (t_Mess(i) * g + v_schall - sqrt(2 * v_schall * t_Mess(i) + v_schall^2));
    s(i,:) = iterbrunnen(t_Mess(i),g,v_schall,max_iter);
end

figure;
hold on;
plot(t_Mess, s, 'b');
plot(t_Mess,s_exakt, 'r');
hold off;


function s = iterbrunnen(t_Mess,g,v_schall,max_iter)
    s = zeros(max_iter,1);
    
    s(1) = g/2 * t_Mess^2;
    
    for i=2:max_iter
        t_schall = s(i-1)/v_schall;
        s(i) = g/2 * (t_Mess-t_schall)^2;
        
        if abs(s(i) - s(i-1)) < 0.0001
            break;
        end
    end
end




