%f'(x) über Vorwärtsdifferenzen
function y = numDiffF(x) 
    y = (myPoly(x+10e-8)-myPoly(x))/10e-8;
end