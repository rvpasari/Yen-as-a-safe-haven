data = csvread('project_data_compute_corr.csv',1,0);
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


monthly_mat = [];
quarterly_mat = [];
yearly_mat = [];


%computing monthly correlations
for i = 1:12;
    USDJPY = [];
    SP = [];
    DAX = [];
    NIKKEI = [];
    FTSE = [];
    MSCI = [];
    ASX = [];
   for j = 1:n;
        if(data(j,1) == i)
            USDJPY = cat(1,USDJPY,data(j,4));
            SP = cat(1,SP,data(j,5));
            NIKKEI = cat(1,NIKKEI,data(j,6));
            DAX = cat(1,DAX,data(j,7));
            FTSE = cat(1,FTSE,data(j,8));
            MSCI = cat(1,MSCI,data(j,9));
            ASX = cat(1,ASX,data(j,10));
            j = j+1;
        end
   end
   a =  corr(USDJPY,SP);
   b =  corr(USDJPY,NIKKEI);
   c =  corr(USDJPY,DAX);
   d =  corr(USDJPY,FTSE);
   e =  corr(USDJPY,MSCI);
   f =  corr(USDJPY,ASX);
   monthly_mat = cat(1,monthly_mat,[a b c d e f]);
end
figure; 
plot(monthly_mat)
title('Monthly Correlations of Indices vs. USDJPY');
xlabel('Month');
ylabel('Correlation')
legend(names)



%computing quarterly correlations
for i = 1:4
    month = [1 2 3; 4 5 6; 7 8 9; 10 11 12];
    USDJPY = [];
    SP = [];
    DAX = [];
    NIKKEI = [];
    FTSE = [];
    MSCI = [];
    ASX = [];
   for j = 1:n;
        if(sum(data(j,1) == month(i,:)) == 1)
            USDJPY = cat(1,USDJPY,data(j,4));
            SP = cat(1,SP,data(j,5));
            NIKKEI = cat(1,NIKKEI,data(j,6));
            DAX = cat(1,DAX,data(j,7));
            FTSE = cat(1,FTSE,data(j,8));
            MSCI = cat(1,MSCI,data(j,9));
            ASX = cat(1,ASX,data(j,10));
            j = j+1;
        end
   end
   a =  corr(USDJPY,SP);
   b =  corr(USDJPY,NIKKEI);
   c =  corr(USDJPY,DAX);
   d =  corr(USDJPY,FTSE);
   e =  corr(USDJPY,MSCI);
   f =  corr(USDJPY,ASX);
   quarterly_mat = cat(1,quarterly_mat,[a b c d e f]);
end

figure; 
plot(quarterly_mat)
title('Quarterly Correlations of Indices vs. USDJPY');
xlabel('Quarters');
ylabel('Correlation')
legend(names)

%computing yearly correlations
for i = 2010:2014
    USDJPY = [];
    SP = [];
    DAX = [];
    NIKKEI = [];
    FTSE = [];
    MSCI = [];
    ASX = [];
    for j = 1:n
        if data(j,3) == i 
            k = k+1;
            USDJPY = cat(1,USDJPY,data(j,4));
            SP = cat(1,SP,data(j,5));
            NIKKEI = cat(1,NIKKEI,data(j,6));
            DAX = cat(1,DAX,data(j,7));
            FTSE = cat(1,FTSE,data(j,8));
            MSCI = cat(1,MSCI,data(j,9));
            ASX = cat(1,ASX,data(j,10));
        end
    end
   a =  corr(USDJPY,SP);
   b =  corr(USDJPY,NIKKEI);
   c =  corr(USDJPY,DAX);
   d =  corr(USDJPY,FTSE);
   e =  corr(USDJPY,MSCI);
   f =  corr(USDJPY,ASX);
   yearly_mat = cat(1,yearly_mat,[a b c d e f]); 
end
indices = [data(:,6) data(:,4) data(:,7) data(:,9)]; 
[U,S,V] = svd(indices,0);

figure; 
plot(yearly_mat)
title('Yearly Correlations of Indices vs. USDJPY');
xlabel('Years');
ylabel('Correlation')
legend(names)

