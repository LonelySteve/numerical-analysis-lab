function [x] = gauss(A, b)
    B = [A, b];
    [n, m] = size(B);
    % 求行阶梯形矩阵
    for k = 1:n
        for o = k+1:n
            B(o, :) = B(o, :) - (B(o, k) / B(k, k)) * B(k,:);
        end
    end
    % 预分配 x 空间
    x = zeros(m-1, 1);
    % 回代求解
    for k = n:-1:1
       x(k) = (B(k, m)  - B(k, k+1: m-1) * x(k+1: m-1) ) / B(k, k);
    end
end
