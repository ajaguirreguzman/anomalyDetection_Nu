
function [epsilon,F1]=select_threshold(y_valid,p_valid)

% initialise
bestF1=0;
bestEpsilon=0;

% define stepsize
stepsize=(max(p_valid)-min(p_valid))/1000;
%min(p_valid):stepsize:max(p_valid)
j=0;
for epsilon=fliplr([0.00001,0.0001,.001,.01,.1,1])
  j=j+1;

  % F1-score
  F1=f1score(y_valid,p_valid,epsilon);

  % record best epsilon yet
  if F1>bestF1
    bestF1=F1;
    bestEpsilon=epsilon;
  end
  fprintf('%i \t %f \t %f\n',j,bestF1,bestEpsilon)

end
