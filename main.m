clear;
clc;
scale =100;%指定每种呼吸模式产生的次数
n_class=6;%呼吸类别数
C=cell(2,scale*6);
for i=1:scale
    %1:Eupnea  
    C(1,i)={Eupnea_function(60,10)};
    C(2,i)={1};
    %2:Bradypnea
    C(1,i+scale)={Bradypnea_function(60,10)};
    C(2,i+scale)={2};
    %3 Tachypnea
    C(1,i+scale*2)={Tachypnea_function(60,10)};
    C(2,i+scale*2)={3};
    %4 Biots
    C(1,i+scale*3)={Biots_function(60,5)};
    C(2,i+scale*3)={4};
    %5 Cheyne_stokes
    C(1,i+scale*4)={Cheyne_Stokes_function(60)};
    C(2,i+scale*4)={5};
    %6 Central_Apnea
    C(1,i+scale*5)={Central_Apnea_function(60,5)};
    C(2,i+scale*5)={6};
    
end
signal=zeros(n_class*scale,601);
for i= 1:n_class*scale
signal(i,2:601)=C{1,i};
end
%归一化处理
signal=mapminmax(signal,0,1);
for i=1:n_class*scale
signal(i,1)=C{2,i};    
end
r=randperm( size(signal,1) );   %生成关于行数的随机排列行数序列
Breathing=signal(r, :);                              %根据这个序列对A进行重新排序
csvwrite('Breathing_TRAIN.csv',Breathing);
