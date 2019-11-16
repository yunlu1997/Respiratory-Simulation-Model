function mat = Noise_function (Time,N)
mat = normrnd(0,1,[1 Time*10]);
point = randi([1, Time*10], 1, N);
value = randi([-10, 10], 1, N);
for i = 1:N
    mat(1,point(1,i)) = value(1,i);
end
