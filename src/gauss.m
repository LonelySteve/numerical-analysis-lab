function x = gauss(A, b)
    % gauss - 使用高斯顺序消元法解线性方程组
    %
    % Syntax: x = gauss(A, b)
    %
    % - A：线性方程组的系数矩阵
    % - b：线性方程组的常数矩阵
    %
    % 返回线性方程组的解 x

    % 通过水平合并系数矩阵 A 和常数矩阵 b 得到增广矩阵 B
    B = [A, b];
    % 获取矩阵 A 的行数 n 和列数 m
    [n, m] = size(B);
    % 求行阶梯形矩阵
    for k = 1:n

        for o = k + 1:n
            B(o, :) = B(o, :) - (B(o, k) / B(k, k)) * B(k, :);
        end

    end

    % 预分配 x 空间
    x = zeros(m - 1, 1);
    % 回代求解
    for k = n:-1:1
        x(k) = (B(k, m) - B(k, k + 1:m - 1) * x(k + 1:m - 1)) / B(k, k);
    end

end
