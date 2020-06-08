function x = catchup(A, f)
    % catchup - 使用追赶法解线性方程组
    %
    % Syntax: x = catchup(A, f)
    %
    % - A：系数矩阵 A，应为三对角矩阵
    % - b：常数矩阵 b
    %
    % 返回线性方程组的解 x

    % 获取矩阵 A 的行数
    [n, ~] = size(A);
    % 初始化 a, b, c 向量
    a = ones(n - 1, 1);
    b = ones(n, 1);
    c = ones(n - 1, 1);

    for row = 1:n - 1% 最多只能遍历到 n-1，否则会越界
        b(row, 1) = A(row, row);
        a(row, 1) = A(row + 1, row);
        c(row, 1) = A(row, row + 1);
    end

    % 因为上面的遍历过程只进行到 n-1 行，因此这里需要补齐 b 向量的最后一个值
    b(n, 1) = A(n, n);
    % 初始化 β
    d = zeros(n - 1, 1);
    % 构建 β
    d(1) = c(1) / b(1);

    for index = 2:n - 1
        d(index) = c(index) / (b(index) - a(index - 1) * d(index - 1));
    end

    % 解 Ly = f
    y = zeros(n, 1); % 初始化 y
    % 构建 y
    y(1) = f(1) / b(1);

    for index = 2:n
        y(index) = (f(index) - a(index - 1) * y(index - 1)) / (b(index) - a(index - 1) * d(index - 1));
    end

    % 解 Ux = y
    x = zeros(n, 1); % 初始化 x
    x(n) = y(n);

    for index = n - 1:-1:1
        x(index) = y(index) - d(index) * x(index + 1);
    end

end
