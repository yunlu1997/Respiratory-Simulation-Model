function output = randa2b( a,b,N )
%a到b之间随机N个数
%一般来说，可以使用公式 r = a + (b-a).*rand(N,1) 生成区间 (a,b) 内的 N 个随机数。 
output=a + (b-a).*rand(N,1);


end

