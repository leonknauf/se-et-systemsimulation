% m-file: fourier_series_fun_02.m
%
% Erklärung
%
% Diese Datei stellt die Funktion fourier_series_fun_01 bereit. 
% Diese Funktion berechnet die Fourierwerte mit den angegebenen
% Koeffizienten.
% 
% Input:    Koeffizienten und Parameter einer Fouriergleichung
% Output:   Berechnete Fourierwerte
%
% Beispiel:
%
% Autor   :	Leon Knauf
%
% Datum:    07.10.2023
%
% Änderung: 
%
% Benötigte eingene externe functions:
%
% siehe auch: 
%
%--------------------------------------------------------------------------         


function y = fourier_series_fun_02(a0,a,b,T,A,t,opt)

if nargin() < 7
    opt = 4;
end

w_0 = (2*pi)/T;
N_koeff = size(a,2);

switch opt
    case 0 % kein plot
        y = zeros(1,size(t,2));

    case 1 % nur die Funktion f(t) darstellen
        summs = fourier_series_fun_02(a0,a,b,T,A,t,3);
        y= sum(summs,1);

    case 2 % alle harmonischen in einem plot
        Phi = w_0*((1:N_koeff)'.*repmat(t,N_koeff,1));

        y= A.* (a'.*cos(Phi)+b'.*sin(Phi));

        % Alternative Lösung:
        % y = zeros(N_koeff,size(t,2));
        % for n=1:N_koeff
        %     y(n,:) = (a0/2) + A .* (a(n) .* cos(n .* w_0 .* t) + b(n) .* sin(n .* w_0 .* t));
        % end
    
    case 3 % alle Teilsummen in einem plot

        harmonische = fourier_series_fun_02(a0,a,b,T,A,t,2);
        num_teilsummen = 10;

        y = reshape(sum(reshape(harmonische,[],400,num_teilsummen), 1), num_teilsummen, 400);

        % Alternative Lösung:
        % n_pro_teilsumme = N_koeff/num_teilsummen;
        % y = zeros(num_teilsummen,size(t,2));
        % summs = zeros(n_pro_teilsumme,size(t,2));
        % 
        % for n=1:num_teilsummen
        %     for i=1:n_pro_teilsumme
        %         x=(n-1)*n_pro_teilsumme+i;
        %         summs(i,:) = A .* (a(x) .* cos(x .* w_0 .* t) + b(x) .* sin(x .* w_0 .* t));
        %     end
        %     y(n,:) = (a0/2) + sum(summs);
        % end

    case 4 % Nutze fourier_series_fun_01
        y = fourier_series_fun_01(a0,a,b,T,A,t);
       
    otherwise % kein plot
        y = zeros(1,size(t,2));
end


