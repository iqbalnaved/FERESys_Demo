% This function convolves the given image in 40 different Gabor phase
% representations. That is, at 8 orientations and 5 scales. Then it enocodes 
% the 40 representations using LGBP operator. Then partitions the LGBP images
% into 64 regions. Finally, extracts local histograms from each region of a
% single image and concatenates them. It returns the 40 local histograms
% generated for each Gabor representations using a cell-array.
function LH = encoding(I, id, method)

scale = 5;
orient = 8;
region = 64;   % number of regions
bin = 256;     % the number of histogram bins (gray level range)

% method = 'magnitude'; 
% method = 'phase';


LH = cell(40,1);
[LH{:}] = deal(cell(scale, orient, region));
for i = 1:40
    [LH{i}{:}] = deal(zeros(1,bin));
end                

k = 1;
for o=1:8
    for s=1:5
        fprintf('\tencoding %s: %s at orient = %d, scale=%d\r', method, id, o, s);

        [EO_Mag EO_Pha] = gaborconvolve(I, s, o);

        if(strcmp(method,'magnitude'))
            LGBP_var = LGBP(EO_Mag);
        else
            LGBP_var = LGBP(EO_Pha);
        end

        LH{k} = local_histogram(LGBP_var, region, bin);   
        k = k + 1;
    end
end