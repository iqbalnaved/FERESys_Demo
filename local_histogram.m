function Hlocal = local_histogram(lgbp, nregion, nbin) %LGBP_Mag or LGBP_Pha

[rows cols] = size(lgbp);            % image size 128x5120
rsize = ( rows * cols ) / nregion;   % region size (128*5120)/64=10240=32*320
factors = factor(rsize); % returns all the prime factors of rsize in an array
rrows = prod(factors(1:floor(length(factors)/2))); % taking the product of half the factors 16
rcols = rsize/rrows; % taking the rest 1280/16=80
colsPerRow = cols/rcols; % number of rows per row in the partitioned image 5120/320=16

% the LGBP image is spatially partitioned into multiple nonoverlapping
% regions with the same size

lgbp_r = cell(1, nregion);
[lgbp_r{:}] = deal(zeros(rrows,rcols));


x = 1; y = 1;        
for r = 1:nregion
    lgbp_r{r}(1:rrows,1:rcols) = lgbp(x:x+rrows-1,y:y+rcols-1);
    y = y + rcols;
    if(mod(r, colsPerRow)==0) %128/16=8
        x = x + rrows;        
        y = 1;
    end
end

% histogram is extracted from each region, this method is called 'local
% hisograms'

Hlocal = cell(1, nregion);
[Hlocal{:}] = deal(zeros(1,nbin));

for r = 1:nregion
    for i = 1:nbin
          z = lgbp_r{r} - i; % make all pixel with i-th gray level zero
          Hlocal{r}(i) = length(find(z == 0)); % count the number of zeros to find out the histogram of i-th gray level
    end
end

end

