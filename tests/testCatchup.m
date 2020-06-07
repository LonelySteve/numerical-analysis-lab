function test_suite = testCatchup

    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions();
    catch % no problem; early Matlab versions can use initTestSuite fine
    end

    initTestSuite;
end

function test_catchup
    A = [
        4 -1 0 0 0 0 0 0 0 0;
        - 1 4 -1 0 0 0 0 0 0 0;
        0 -1 4 -1 0 0 0 0 0 0;
        0 0 -1 4 -1 0 0 0 0 0;
        0 0 0 -1 4 -1 0 0 0 0;
        0 0 0 0 -1 4 -1 0 0 0;
        0 0 0 0 0 -1 4 -1 0 0;
        0 0 0 0 0 0 -1 4 -1 0;
        0 0 0 0 0 0 0 -1 4 -1;
        0 0 0 0 0 0 0 0 -1 4;
        ]
    f = [

        7;
        5;
        -13;
        2;
        6;
        -12;
        14;
        -4;
        5;
        -5;
        ]

    assertElementsAlmostEqual([2, 1, -3, 0, 1, -2, 3, -0, 1, -1], catchup(A, f));
end
