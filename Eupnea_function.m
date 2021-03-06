function  mat  = Eupnea_function( Time,N )
% %采样间隔为0.1s，设定时间为Time
% Time=180;
%随机在0，60的整数秒内产生N个断点，并排序
%N=30;
r =sort( randi([0 Time],N,1));

%划定N+1个区间
C(1,:)={0:0.1:r(1,:)};
for i = 1:N-1
    C(i+1,:)={r(i,:):0.1:r(i+1,:)};
end
C(N+1,:)={r(N,:):0.1:Time};

%分段生成呼吸信号
for i =1:N+1
    %Eupnea a在0.3至0.5随机，b在1.37至1.77随机，c在-0.4至+0.4随机，d在-0.1至+0.1随机
    C{i,2} =  Breathing(C{i,1},randa2b(0.3,0.5,1),randa2b(1.27,1.77,1),randa2b(-0.4,0.4,1),randa2b(-0.1,0.1,1));
end
%连接N个断点

for i=1:N
    C{i,2}(:,end)=C{i+1,2}(:,1);
end

%将Cell存入mat
index=0;
for i=1:N+1
    for j=1:length(C{i,1})-1
    index= index+1;
    %mat(index,1) = C{i,1}(j);
    mat(1,index) = C{i,2}(j);
    end
end
%添加高斯噪声，SNR为20
mat(1,:) = awgn(mat(1,:),20,'measured');





end

