function mat = Cheyne_Stokes_function(Sum_Time)
%Example:Cheyne_Stokes （一个周期60秒，窒息时间取最后10s并且向前随机）
%采样间隔为0.1s，设定时间为Time
Time=60;
Num_T=Sum_Time/Time;
for T = 0:Num_T-1
%随机在0，50秒内产生5个断点，并排序
N=5;
r(1,:)= randi([T*Time 4+T*Time],1,1);
r(2,:)= randi([10+T*Time 14+T*Time],1,1);
r(3,:)= randi([16+T*Time 20+T*Time],1,1);
r(4,:)=randi([26+T*Time 30+T*Time],1,1);
r(5,:)=randi([38+T*Time 40+T*Time],1,1);

%划定N+2个区间
C(1+T*(N+2),:)={T*Time:0.1:r(1,:)};
for i = 1:N-1
    C(i+1+T*(N+2),:)={r(i,:):0.1:r(i+1,:)};
end
%在最后一个断点和40秒之间再随机产生一个断点，产生窒息
rand_apnea=randi([r(N,:) (T+1)*Time-20],1,1);
C(N+1+T*(N+2),1)={r(N,:):0.1:rand_apnea};
C(N+2+T*(N+2),1)={rand_apnea:0.1:(T+1)*Time};

%分段生成呼吸信号
%Cheyne_Stkoes较浅的呼吸阶段 a在0.1至0.3随机，b在1.37至1.77随机，c在-0.05至+0.05随机，d在-0.1至0.1随机
%Cheyne_Stkoes较浅的呼吸阶段 a在0.3至0.4随机，b在1.37至1.77随机，c在-0.05至+0.05随机，d在-0.1至0.1随机
%Cheyne_Stkoes较深的呼吸阶段 a在0.4至0.8随机，b在1.37至1.77随机，c在-0.05至+0.05随机，d在-0.1至0.1随机
C{1+T*(N+2),2} =  Breathing(C{1+T*(N+2),1},randa2b(0.2,0.4,1),randa2b(1.37,1.77,1),randa2b(-0.05,0.05,1),randa2b(-0.1,0.1,1));
C{2+T*(N+2),2} =  Breathing(C{2+T*(N+2),1},randa2b(0.2,0.4,1),randa2b(1.37,1.77,1),randa2b(-0.05,0.05,1),randa2b(-0.1,0.1,1));
C{3+T*(N+2),2} =  Breathing(C{3+T*(N+2),1},randa2b(0.6,0.9,1),randa2b(1.37,1.77,1),randa2b(-0.05,0.05,1),randa2b(-0.1,0.1,1));
C{4+T*(N+2),2} =  Breathing(C{4+T*(N+2),1},randa2b(0.6,0.9,1),randa2b(1.37,1.77,1),randa2b(-0.05,0.05,1),randa2b(-0.1,0.1,1));
C{5+T*(N+2),2} =  Breathing(C{5+T*(N+2),1},randa2b(0.2,0.4,1),randa2b(1.37,1.77,1),randa2b(-0.05,0.05,1),randa2b(-0.1,0.1,1));
C{6+T*(N+2),2} =  Breathing(C{6+T*(N+2),1},randa2b(0.2,0.4,1),randa2b(1.37,1.77,1),randa2b(-0.05,0.05,1),randa2b(-0.1,0.1,1));
%Biots窒息阶段 a在-0.05至0.05随机，b在0.01至3.14随机，c在-0.01至+0.01随机，d在-0.01至0.01随机
C{7+T*(N+2),2}= Breathing(C{7+T*(N+2),1},randa2b(-0.05,0.05,1),randa2b(0.01,3.14,1),randa2b(-0.2,0.2,1),randa2b(-0.01,0.01,1));

% %连接N个断点
% for i=1:N+1
%     C{i,2}(:,end)=C{i+1,2}(:,1);
% end
end

%将Cell存入mat
index=0;
for i=1:(N+2)*Num_T
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

% %绘制呼吸波形
% plot(mat(:,1),mat(:,2));
% title('Cheyne Stokes')
% xlabel('Time')
% ylabel('Intensity')
% axis([0 Time*3 -1 1]);
