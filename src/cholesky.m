function [L, U] = cholesky(A)
    % cholesky - Cholesky 分解
    %
    % Syntax: [x] = cholesky(A)
    %
    % - A：线性方程组的系数矩阵，必须为厄米特矩阵或符合正定矩阵定义的矩阵
    % - b：线性方程组的常数矩阵
    %
    % 返回被分解矩阵的下三角矩阵 L 和上三角矩阵 U

    % 获取矩阵 A 的行数 n
    [n, ~] = size(A);
    % 初始化矩阵 L
    L = zeros(n, n);
    % Cholesky–Crout - 从矩阵 L 的左上角开始，依列进行计算
    for col = 1:n

        for row = col:n
            % 对角线元素
            if row == col
                L(row, col) = sqrt(A(row, col) - sum(L(row, 1:col - 1).^2));
            else % 非对角线元素
                L(row, col) = (A(row, col) - ...
                    L(row, 1:col -1) * L(col, 1:col - 1)') / L(col, col);
            end

        end

    end

    U = L';
end
