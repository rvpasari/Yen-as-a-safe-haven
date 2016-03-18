data = csvread('project data.csv',1,1);
[n,p] = size(data);
names = {'S&P 500';'NIKKEI';'DAX';'FTSE';'MSCI';'ASX'};

% making modifications to the data set
for j = 1:p
    for i = 2:n
        if (data(i,j) == 0)
            data(i,j) = data(i-1,j);
           
        end
    end
end

USDJPY = data(:,1);
SP = data(:,2);
NIKKEI = data(:,3);
DAX = data(:,4);
FTSE = data(:,5);
MSCI = data(:,6);
ASX = data(:,7);
indices = [SP NIKKEI DAX FTSE MSCI ASX];
k = length(indices);

cor = [];
for i = 2:p
    index = data(:,i);
    cor = cat(1,cor,corr(index,USDJPY));
end

sol_mat = [];
error_mat = [];
r = [];
coeff = [];
%least squares analysis of all indices done below
for i = 2:p
    x = linspace(0,1,n);
    lsq = [data(:,i) ones(n,1)];
    c = pinv(lsq)*USDJPY; 
    coeff = cat(1,coeff,c');
    sol = lsq*c;
    sol_mat = cat(2,sol_mat,sol);
    figure;
    hold on;
    str = [names(i-1),' VS. USDJPY OVER 5 YEARS'];
    str = strcat(str(1),str(2));
    title(str);
    
    %plotting the least squares data over the actual data
    plot(x,USDJPY,'b');
    plot(x,sol,'r');
    xlabel('10/01/2009  - 12/19/2014');
    ylabel('USDJPY');
    legend('Original Data','Fitted Results');

   
    %linear regression
    yresid = USDJPY - sol;
    SSresid = sum(yresid.^2);
    SStotal = (length(USDJPY)-1) * var(USDJPY);
    rsq = 1 - SSresid/SStotal;
    r = cat(1,r,rsq);
    
    %error computation of each indices
    error = sol_mat(:,i-1)-USDJPY;
    error_percent = (error./USDJPY)*100;
    error_mat = cat(2,error_mat,error_percent);
    
end


figure;
hold on;


% plotting our error distribution on a histogram
for i = 1:(p-1)
    subplot(3,2,i);
    hold on;
    str = ['ERROR IN THE ', names(i),' DATA OVER 10 YEARS'];
    str = strcat(str(1),str(2),str(3));
    title(str);
    hist(error_mat(:,i),50);
    [counts, center] = hist(error_mat(:,i),20);
    axis([-20 20 0 200]);
    xlabel('Percentage Error');
    ylabel('Count');
    norm_error = norm(sol_mat(:,i)-USDJPY)
    corr(USDJPY,sol_mat(:,i))
end

%MAJORS COMBINED

%least squares
lsq_indices = [indices ones(n,1)];
c_indices = pinv(lsq_indices)*USDJPY
sol_indices = lsq_indices*c_indices;
figure;
hold on;
title('MAJOR INDICES VS. USDJPY OVER 5 YEARS');
plot(x,USDJPY,'b');
plot(x,sol_indices,'r');
xlabel('10/01/2009  - 12/19/2014');
ylabel('USDJPY');
legend('Original Data','Fitted Results');

%linear regression
yresid = USDJPY - sol_indices;
SSresid = sum(yresid.^2);
SStotal = (length(USDJPY)-1) * var(USDJPY);
r_all = 1 - SSresid/SStotal;



%error analysis
error_indices = sol_indices-USDJPY;
error_indices_percent = 100*(error_indices./USDJPY);
figure;
hold on;
title('ERROR WITH ALL THE MAJORS COMBINED OVER 5 YEARS');
hist(error_indices_percent,50);
[counts_indices, center_indices] = hist(error_indices_percent,20);
axis([-20 20 0 200]);
xlabel('Percentage Error');
ylabel('Count');
norm_error_indices = norm((sol_indices-USDJPY))

%correlation
corr(USDJPY,sol_indices)



