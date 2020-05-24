function test_suite=testSquareRoot
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions=localfunctions();
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_square_root
    A = [
        4     2    -4     0     2     4     0     0;
        2     2    -1    -2     1     3     2     0;
       -4    -1    14     1    -8    -3     5     6;
        0    -2     1     6    -1    -4    -3     3;
        2     1    -8    -1    22     4   -10    -3;
        4     3    -3    -4     4    11     1    -4;
        0     2     5    -3   -10     1    14     2;
        0     0     6     3    -3    -4     2    19;
    ];
    b = [
        0;
        -6;
        20;
        23;
         9;
       -22;
       -15;
        45;
    ];
    assertElementsAlmostEqual(mldivide(A, b), squareRoot(A, b));
end
