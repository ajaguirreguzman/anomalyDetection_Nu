% Anomaly detection algorithm

%% Initialise
clear ; close all; clc

%% Read and plot data
fprintf('Plotting data ...\n')
data=load('nusse2.out');
x1=data(:,1); % time
x2=data(:,2); % nusselt
m=length(x2); % number of training examples

% plot x1
figure
ax1=gca;
plot(ax1,x1);
hold on

% plot x2
figure
ax2=gca;
scatter(ax2,x1,x2,'.');
hold on

%% Fix time discontinuities

[x1f,x2f]=fixtimedisc(x1,x2);

% plot filtered x1
plot(ax1,x1f);

% plot filtered x2
scatter(ax2,x1f,x2f,'.');

%% Plot histogram

figure
histogram(x2f,250)

%% Parameter estimation: mean, variance

[mu,sigma2]=fitparam(x2f);
fprintf('Mean     = %f\n',mu)
fprintf('Variance = %f\n',sigma2)

%% Probability density function

p=gaussian(x2f,mu,sigma2);

%% Flag anomalous based on manually chosen threshold

% threshold
epsilon=0.001;

% anomalous data
x1f_anom=x1f(p<epsilon);
x2f_anom=x2f(p<epsilon);

% good data
x1f_good=x1f(p>=epsilon);
x2f_good=x2f(p>=epsilon);

%% Plot flagged anomalous and not anomalous data

figure
scatter(x1f_anom,x2f_anom,'r.'); hold on
scatter(x1f_good,x2f_good,'b.');

%% Shuffle anomalous data
shuffled_idxs=randperm(length(x2f_anom));
x2f_anom=x2f_anom(shuffled_idxs);

%% Data preparation: training, validation and test data sets

% indices for 60%/20%/20% subsets of good data
m=length(x1f_good);
subset1_good=1:floor(.6*m);
subset2_good=(floor(.6*m)+1):floor(.8*m);
subset3_good=(floor(.8*m)+1):m;

% indices for 50%/50% subsets of anomalous data
m=length(x1f_anom);
subset1_anom=1:floor(.5*m);
subset2_anom=(floor(.5*m)+1):m;

% training set = 60% of good data
%x1_train=x1f_good(subset1_good);
x2_train=x2f_good(subset1_good);

% validation set = 20% of good data + 50% of anomalous data
%x1_valid=[x1f_good(subset2_good), x1f_anom(subset1_anom)];
x2_valid=[x2f_good(subset2_good), x2f_anom(subset1_anom)];

% test set = 20% of good data
%x1_test=[x1f_good(subset3_good), x1f_anom(subset2_anom)];
x2_test=[x2f_good(subset3_good), x2f_anom(subset2_anom)];

% label good and anomalous data in validation set
y_valid=[zeros(1,length(subset2_good)), ones(1,length(subset1_anom))];

% label good and anomalous data in test set
y_test=[zeros(1,length(subset3_good)), ones(1,length(subset2_anom))];

%% Fit model on training set

[mu,sigma2]=fitparam(x2_train);

fprintf('Mean     = %f\n',mu)
fprintf('Variance = %f\n',sigma2)

%% Probability of validation and test examples for the fitted parameters

p_valid=gaussian(x2_valid,mu,sigma2);
p_test =gaussian(x2_test ,mu,sigma2); % to be used later

%% Select threshold

[epsilon,F1]=select_threshold(y_valid,p_valid);
fprintf('Best epsilon from validation set: %e\n', epsilon);
fprintf('Best F1 from validation set: %f\n', F1);

%% Plot flagged good and anomalous data

% shuffle data
shuffled_idxs=randperm(length(x2_valid));
x2_valid_rand=x2_valid(shuffled_idxs);
p_valid_rand=p_valid(shuffled_idxs);

% plot data
figure
plot(x2_valid_rand(p_valid_rand<epsilon),'r.'); hold on
plot(x2_valid_rand(p_valid_rand>=epsilon),'b.');
title('Validation set')

%% F1-score from test set

F1=f1score(y_test,p_test,epsilon);
fprintf('F1-score from test set: %f\n',F1);

%%  Plot test set

% shuffle data
shuffled_idxs=1:length(x2_test);%randperm(length(x2_test));
x2_test_rand=x2_test(shuffled_idxs);
p_test_rand=p_test(shuffled_idxs);

% plot data
figure
plot(x2_test_rand(p_test_rand<epsilon),'r.'); hold on
plot(x2_test_rand(p_test_rand>=epsilon),'b.');
title('Test set')
