function mat= Central_Apnea_function(Sum_Time,N)
%Example:Central Apnea （一个周期60秒，窒息时间随机取最后20s并向前随机）
%采样间隔为0.1s，每个周期时间为Time（默认60秒），周期数为T_num
Time=60;
T_num=Sum_Time/Time;
for T = 0:T_num-1
%随机在0，Time-10的整数秒内产生N个断点，并排序
r =sort( randi([T*Time (T+1)*Time-20],N,1));
%划定N+2个区间
C(1+T*(N+2),:)={T*Time:0.1:r(1,:)};
    for i = 1:N-1
        C(i+1+T*(N+2),1)={r(i,:):0.1:r(i+1,:)};
    end
%在最后一个断点和50秒之间再随机产生一个断点，产生窒息
rand_apnea=randi([r(N,:) (T+1)*Time-20],1,1);
C(N+1+T*(N+2),1)={r(N,:):0.1:rand_apnea};
C(N+2+T*(N+2),1)={rand_apnea:0.1:(T+1)*Time};

%分段生成呼吸信号
    for i =1:N+1
        %Central Apnea 正常呼吸阶段 a在0.3至0.6随机，b在1.37至1.77随机，c在-0.05至+0.05随机，d在-0.1至+0.1随机
        C{i+T*(N+2),2} =  Breathing(C{i+T*(N+2),1},randa2b(0.3,0.6,1),randa2b(1.37,1.77,1),randa2b(-0.05,0.05,1),randa2b(-0.1,0.1,1));
    end
%Biots窒息阶段
%a在-0.05至0.05随机，b在0.01至3.14随机，c在-0.05至+0.05随机，d在-0.01至0.01随机
C{N+2+T*(N+2),2}= Breathing(C{N+2+T*(N+2),1},randa2b(-0.05,0.05,1),randa2b(0.01,3.14,1),randa2b(-0.2,0.2,1),randa2b(-0.01,0.01,1));

%连接N个断点
%     for i=1:N+1
%         C{i+T,2}(:,end)=C{i+1+T,2}(:,1);
%     end
end

%将Cell存入mat
index=0;
for i=1:(N+2)*T_num
    for j=1:length(C{i,1})-1
    index= index+1;
    %mat(index,1) = C{i,1}(j);
    mat(1,index) = C{i,2}(j);
    end
end
%添加高斯噪声，SNR为20
mat(1,:) = awgn(mat(1,:),20,'measured');
%保存mat
%save F:\mat\Eupnea\test1 mat

%绘制呼吸波形
% plot(mat(:,1),mat(:,2));
% title('Central_Apnea')
% xlabel('Time')
% ylabel('Intensity')
% axis([0 Time*(T+1) -2 2]);