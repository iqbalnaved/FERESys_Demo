%local Gabor binary patterns(LGBP) combines Gabor magnitudes (or phases)
%with local binary patterns(LBP)operator.
function lgbp = LGBP(EO) %EO_Mag or EO_Pha

[rows cols] = size(EO);

lgbp = zeros(rows,cols);

padEOcell = padarray(EO,[1 1]);
for i = 2:rows+1
    for j = 2:cols+1
              lgbp(i-1,j-1) = (padEOcell(i-1,j-1) >= padEOcell(i,j))      +...
                              (padEOcell(i-1,j)   >= padEOcell(i,j)) * 2  +...
                              (padEOcell(i-1,j+1) >= padEOcell(i,j)) * 4  +...
                              (padEOcell(i,  j+1) >= padEOcell(i,j)) * 8  +...
                              (padEOcell(i+1,j+1) >= padEOcell(i,j)) * 16 +...
                              (padEOcell(i+1,j)   >= padEOcell(i,j)) * 32 +...
                              (padEOcell(i+1,j-1) >= padEOcell(i,j)) * 64 +...
                              (padEOcell(i,  j-1) >= padEOcell(i,j)) * 128;
    end
end

end

