function test_suite=testGauss
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions=localfunctions();
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_gauss
    A = [
        4    2    -3    -1   2    1     0    0    0    0  ;
        8    6    -5    -3   6    5     0    1    0    0  ;
        4    2    -2    -1   3    2     -1   0    3    1  ;
        0    -2   1     5    -1   3     -1   1    9    4  ;
        -4   2    6     -1   6    7     -3   3    2    3  ;
        8    6    -8    5    7    17    2    6    -3   5  ;
        0    2    -1    3    -4   2     5    3    0    1  ;
        16   10   -11   -9   17   34    2    -1   2    2  ;
        4    6    2     -7   13   9     2    0    12   4  ;
        0    0    -1    8    -3   -24   -8   6    3    -1;
    ];
    b = [
        5  ;
        12 ;
        3  ;
        2  ;
        3  ;
        46 ;
        13 ;
        38 ;
        19 ;
        -21;
    ];
    assertElementsAlmostEqual(mldivide(A, b), gauss(A, b));
end