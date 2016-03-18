data = csvread('project data 5 years.csv',1,1);
[n,p] = size(data);

% making modifications to the data set
for j = 1:p
    for i = 2:n
        if (data(i,j) == 0)
            data(i,j) = data(i-1,j);
           
        end
    end
end


%extracting the indices to study the correlations 
USDJPY = data(:,1);
DAX = data(:,4);

SP = data(:,2);
NIKKEI = data(:,3);
FTSE = data(:,5);
MSCI = data(:,6);
ASX = data(:,7);
indices = [SP NIKKEI DAX FTSE ASX];


%correlation analysis    

corr(SP,USDJPY)
corr(NIKKEI,USDJPY)
corr(DAX,USDJPY)
corr(FTSE,USDJPY)
corr(MSCI,USDJPY)
corr(ASX,USDJPY)
corr(indices)



%SP500
x = linspace(0,1,n);
lsq_sp = [SP ones(n,1)];
c_sp = pinv(lsq_sp)*USDJPY
sol_sp = lsq_sp*c_sp;
figure;
hold on;
title('S&P 500 RESULTS');
plot(x,USDJPY,'b');
plot(x,sol_sp,'r');
xlabel('11/01/2009  - 11/30/2014');
ylabel('USDJPY');
legend('Original Data','Fitted Results');


%DAX
lsq_dax = [DAX ones(n,1)];
c_dax = pinv(lsq_dax)*USDJPY
sol_dax = lsq_dax*c_dax;
figure;
hold on;
title('DAX RESULTS');
plot(x,USDJPY,'b');
plot(x,sol_dax,'r');
xlabel('11/01/2009  - 11/30/2014');
ylabel('USDJPY');
legend('Original Data','Fitted Results');


%NIKKEI
lsq_nikkei = [NIKKEI ones(n,1)];
c_nikkei = pinv(lsq_nikkei)*USDJPY
sol_nikkei = lsq_nikkei*c_nikkei;
figure;
hold on;
title('NIKKEI RESULTS');
plot(x,USDJPY,'b');
plot(x,sol_nikkei,'r');
xlabel('11/01/2009  - 11/30/2014');
ylabel('USDJPY');
legend('Original Data','Fitted Results');

%FTSE
lsq_ftse = [FTSE ones(n,1)];
c_ftse = pinv(lsq_ftse)*USDJPY
sol_ftse = lsq_ftse*c_ftse;
figure;
hold on;
title('FTSE RESULTS');
plot(x,USDJPY,'b');
plot(x,sol_ftse,'r');
xlabel('11/01/2009  - 11/30/2014');
ylabel('USDJPY');
legend('Original Data','Fitted Results');

%MSCI
lsq_msci = [MSCI ones(n,1)];
c_msci = pinv(lsq_msci)*USDJPY
sol_msci = lsq_msci*c_msci;
figure;
hold on;
title('MSCI RESULTS');
plot(x,USDJPY,'b');
plot(x,sol_msci,'r');
xlabel('11/01/2009  - 11/30/2014');
ylabel('USDJPY');
legend('Original Data','Fitted Results');

%ASX
lsq_asx = [ASX ones(n,1)];
c_asx = pinv(lsq_asx)*USDJPY
sol_asx = lsq_asx*c_asx;
figure;
hold on;
title('ASX RESULTS');
plot(x,USDJPY,'b');
plot(x,sol_asx,'r');
xlabel('11/01/2009  - 11/30/2014');
ylabel('USDJPY');
legend('Original Data','Fitted Results');

%All in one
lsq_indices = [indices ones(n,1)];
c_indices = pinv(lsq_indices)*USDJPY
sol_indices = lsq_indices*c_indices;
figure;
hold on;
title('MAJOR INDICES RESULTS');
plot(x,USDJPY,'b');
plot(x,sol_indices,'r');
xlabel('11/01/2009  - 11/30/2014');
ylabel('USDJPY');
legend('Original Data','Fitted Results');


%error

%SP 500
error_sp = sol_sp-USDJPY;
error_sp_percent = (error_sp./USDJPY)*100;
figure;
subplot(3,2,1);
hold on;
title('ERROR IN THE S&P 500 DATA');
hist(error_sp_percent,50);
[counts_sp, center_sp] = hist(error_sp_percent,20);
axis([-20 20 0 200]);
xlabel('Percentage Error');
ylabel('Count');
norm_error_sp = norm(sol_sp-USDJPY)
corr(USDJPY,sol_sp)

%NIKKEI
error_nikkei = sol_nikkei-USDJPY;
error_nikkei_percent = 100*(error_nikkei./USDJPY);
subplot(3,2,2);
hold on;
title('ERROR IN THE NIKKEI DATA');
hist(error_nikkei_percent,20);
[counts_nikkei, center_nikkei] = hist(error_nikkei_percent,20);
axis([-20 20 0 250]);
xlabel('Percentage Error');
ylabel('Count');
norm_error_nikkei = norm((sol_nikkei-USDJPY))
corr(USDJPY,sol_nikkei)

%DAX
error_dax = sol_dax-USDJPY;
error_dax_percent = 100*(error_dax./USDJPY);
subplot(3,2,3);
hold on;
title('ERROR IN THE DAX DATA');
hist(error_dax_percent,50);
[counts_dax, center_dax] = hist(error_dax_percent,20);
axis([-20 20 0 200]);
xlabel('Percentage Error');
ylabel('Count');
norm_error_dax = norm((sol_dax-USDJPY))
corr(USDJPY,sol_dax)


%FTSE
error_ftse = sol_ftse-USDJPY;
error_ftse_percent = 100*(error_ftse./USDJPY);
subplot(3,2,4);
hold on;
title('ERROR IN THE FTSE DATA');
hist(error_ftse_percent,50);
[counts_ftse, center_ftse] = hist(error_ftse_percent,20);
axis([-20 20 0 200]);
xlabel('Percentage Error');
ylabel('Count');
norm_error_ftse = norm((sol_ftse-USDJPY))
corr(USDJPY,sol_ftse)

%MSCI
error_msci = sol_msci-USDJPY;
error_msci_percent = 100*(error_msci./USDJPY);
subplot(3,2,5);
hold on;
title('ERROR IN THE MSCI DATA');
hist(error_msci_percent,20);
[counts_msci, center_msci] = hist(error_nikkei_percent,20);
axis([-20 20 0 250]);
xlabel('Percentage Error');
ylabel('Count');
norm_error_msci = norm((sol_msci-USDJPY))
corr(USDJPY,sol_msci)


%ASX
error_asx = sol_asx-USDJPY;
error_asx_percent = 100*(error_asx./USDJPY);
subplot(3,2,6);
hold on;
title('ERROR IN THE ASX DATA');
hist(error_asx_percent,20);
[counts_asx, center_asx] = hist(error_asx_percent,20);
axis([-20 20 0 250]);
xlabel('Percentage Error');
ylabel('Count');
norm_error_asx = norm((sol_asx-USDJPY))
corr(USDJPY,sol_asx)

%MAJORS COMBINED
error_indices = sol_indices-USDJPY;
error_indices_percent = 100*(error_indices./USDJPY);
figure;
hold on;
title('ERROR WITH ALL THE MAJORS COMBINED');
hist(error_indices_percent,50);
[counts_indices, center_indices] = hist(error_indices_percent,20);
axis([-20 20 0 200]);
xlabel('Percentage Error');
ylabel('Count');
norm_error_indices = norm((sol_indices-USDJPY))

corr(USDJPY,sol_indices)

