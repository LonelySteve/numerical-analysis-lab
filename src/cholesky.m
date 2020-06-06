function [L, U] = cholesky(A)
    %cholesky - Cholesky 分解
    %
    % Syntax: [x] = cholesky(A)
    %
    % Cholesky 分解，被分解的矩阵必须为厄米特矩阵或符合正定矩阵定义的矩阵
    % 返回被分解矩阵的下三角矩阵 L 和上三角矩阵 U
    [n, ~] = size(A);
    L = zeros(n, n);
    % Cholesky–Crout
    for col = 1:n
        for row = col: n
            if row == col
                L(row, col) = sqrt(A(row, col) - sum(L(row, 1:col-1) .^ 2));
            else
                L(row, col) = (A(row, col) - ... 
                    L(row, 1:col -1) * L(col, 1:col - 1)') / L(col, col);
            end
        end
    end
    U = L';
end
