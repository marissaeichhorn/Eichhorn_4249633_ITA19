%f'(x) über Rückwärtsdifferenzen
function y = numDiffB(x) 
    y = (myPoly(x)-myPoly(x-10e-8))/10e-8;
end
