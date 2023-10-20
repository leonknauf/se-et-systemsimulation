%
function [x,y]=Koch_Flocke_fun(punkte, maxtiefe, tiefe, startpunkte)

% Anzahl der Argumente prüfen
if (nargin() < 3)
    tiefe = 1;
    startpunkte = punkte;
end

% Anzahl aktueller Punkte bestimmen
num_punkte = size(punkte,2);

% Anzahl Punkte der Grundgeometrie bestimmen
num_startpunkte = size(startpunkte,2);

% Anzahl neuer Punkte bestimmen
num_neue_punkte = num_startpunkte * (num_punkte - 1) + 1;

% Matrix für neue Punkte anlegen
neue_punkte = zeros(2,num_neue_punkte);

% Alle bestehenden Punkte durchlaufen
for i=1:num_punkte
    % Neuen Index bestimmen
    idx = (i-1)*(num_startpunkte-1)+i;

    % Punkt in die neue Matrix kopieren
    neue_punkte(:,idx) = punkte(:,i);

    % Neue Punkte generieren
    if i<num_punkte

        % Erster neuer punkt
        p1 = punkte(:,i) + (punkte(:,i+1) - punkte(:,i))/3;
        
        % Letzter neuer punkt
        p3 = punkte(:,i+1) - (punkte(:,i+1) - punkte(:,i))/3;
        
        % Mittleren neuen Punkt berechnen
        p2 = [0;0];
        p2(1) = p1(1) + (p3(1) - p1(1)) / 2+sqrt(3) * (p1(2) - p3(2))/2;
        p2(2) = p1(2) + (p3(2) - p1(2)) / 2+sqrt(3) * (p3(1) - p1(1))/2;

        % Neue Punkte in Matrix eintragen
        neue_punkte(:,idx+1) = p1;
        neue_punkte(:,idx+2) = p2;
        neue_punkte(:,idx+3) = p3;
    end
end

% Abbruchbedingung der Rekursion
if tiefe < maxtiefe
    [x,y] = Koch_Flocke_fun(neue_punkte,maxtiefe,tiefe+1,startpunkte);
else
    x = neue_punkte(1,:);
    y = neue_punkte(2,:);
end

end

