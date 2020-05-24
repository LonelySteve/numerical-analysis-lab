function [L, U] = cholesky(A)
    %cholesky - Cholesky 分解
    %
    % Syntax: [x] = cholesky(A)
    %
    % Cholesky 分解，被分解的矩阵必须为厄米特矩阵或符合正定矩阵定义的矩阵
    % 返回被分解矩阵的下三角矩阵 L 和上三角矩阵 U
    [~, n] = size(A);

    if n == 0
        L = [];
        U = [];
        return;
    end

    L(1, 1) = sqrt(A(1, 1));
    L(2:n, 1) = A(2:n, 1) ./ L(1, 1);
    A_ = A(2:n, 2:n) - L(2:n, 1) * L(2:n, 1)';
    [L(2:n, 2:n), ~] = cholesky(A_);
    U = L';
end
