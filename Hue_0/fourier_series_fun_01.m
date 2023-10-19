% m-file: fourier_series_fun_01.m
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


function y = fourier_series_fun_01(a0,a,b,T,A,t);

% w0 berechnen
w_0 = 2*pi/T;

% Anzahl an Koeffizienten aus Matrixgröße von a ermitteln
N_koeff = size(a,2);

% Fouriereihe berechnen mit Formel aus Teilaufgabe 5
y = a0/2 + A * (a * cos(w_0*((1:N_koeff)'.*repmat(t,N_koeff,1))) +...
                b * sin(w_0*((1:N_koeff)'.*repmat(t,N_koeff,1))));



% Alternative Lösung mit Schleifen

% sum_elements = zeros(1,size(t,2));
% sum_element = zeros(1,size(a,2));
% 
% for t_n=1:size(t,2)
%     for n=1:size(a,2)
%         sum_element(n) = a(n) * cos(n * w_0 * t(t_n)) + b(n) * sin(n * w_0 * t(t_n));
%     end
%     sum_elements(t_n) = sum(sum_element);
% end
% 
% y = a0/2 + A .* sum_elements;