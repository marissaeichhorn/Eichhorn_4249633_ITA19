%f'(x) über Zentraldifferenzen
function y = numDiffC(x) 
    y = (myPoly(x+10e-6)-myPoly(x-10e-6))/(2*10e-6);
end