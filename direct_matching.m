%in the direct matching method histogram intersection (HI) is used to
%measure the similarity of differnt histograms.
function S = direct_matching(LH1, LH2, nregion, similarity_measure)

S = 0;

if strcmp(similarity_measure, 'direct')
    for r=1:nregion
        S = S + sum(min(LH1{r},LH2{r}));
    end
else 
    for r=1:nregion
        X = [LH1{r}' LH2{r}'];        
        S = S + sum(pdist(X, similarity_measure));
    end
end
    
