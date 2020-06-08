function [x] = squareRoot(A, b)
    % squareRoot - 使用平方根法解线性方程组
    %
    % Syntax: [x] = squareRoot(A, b)
    %
    % - A：线性方程组的系数矩阵，必须为厄米特矩阵或符合正定矩阵定义的矩阵
    % - b：线性方程组的常数矩阵
    %
    % 返回线性方程组的解 x

    % 获取矩阵 A 的行数
    [n, ~] = size(A);
    % 使用 cholesky 算法对矩阵进行分解
    [L, U] = cholesky(A);

    % 由 LUx = b 进行分解得：
    % Ly = b
    % y = Ux
    % 故可以先计算 y ，再计算 x

    % 回代计算 y
    y = zeros(n, 1); % 初始化 y

    for k = 1:n
        j = 1:k - 1;
        y(k) = (b(k) - L(k, j) * y(j)) / L(k, k);
    end

    % 回代计算 x
    x = zeros(n, 1); % 初始化 x

    for k = n:-1:1
        j = k + 1:n;
        x(k) = (y(k) - U(k, j) * x(j)) / U(k, k);
    end

end
