% fixtimedisc(x1,x2) returns the filtered
% (i.e. time-continuous) data in x1 and x2.
% The filtering is done over discontinuities
% in x1 (i.e. time).

function [x1f,x2f]=fixtimedisc(x1,x2)

% number of training examples
m=length(x1);

% initialise
j=0;
d=0;

% allocate enough memory
x1f=zeros(1,m);
x2f=zeros(1,m);

for i=2:m
  
  % find discountinuity
  if x1(i)<x1(i-1)
    d=x1(i-1);
    fprintf('Time discontinuity at %.2f\n',d)
  end
  
  % save if larger than discontinuity
  if x1(i)>d
    j=j+1;
    x1f(j)=x1(i);
    x2f(j)=x2(i);
  end

end

% clean unnecessary allocated space
x1f=x1f(x1f>0);
x2f=x2f(x1f>0);

end
