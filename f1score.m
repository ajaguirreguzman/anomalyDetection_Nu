
function F1=f1score(y,p,epsilon)

predictions=p<epsilon;

% true positives
tp=sum((predictions==1) & (y==1));

% false positives
fp=sum((predictions==1) & (y==0));

% false negatives
fn=sum((predictions==0) & (y==1));

% precision
prec=tp/(tp+fp);

% recall
rec=tp/(tp+fn);

% F1-score
F1=2*prec*rec/(prec+rec);

end
