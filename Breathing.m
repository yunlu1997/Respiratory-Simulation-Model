function [ Breathing_signal ] = Breathing(x,a,b,c ,d)
%a为幅度，即呼吸深度。
%b为频率，即呼吸速率。
%c为每个断点之间的幅度偏移量。
%d为每一段波形随时间的幅度偏移
%SNR为信噪比。
%   此处显示详细说明
Breathing_signal =a*sin(b*x)+c+d*(x-x(1));

end

