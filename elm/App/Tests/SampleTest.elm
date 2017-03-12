module App.Tests.SampleTest exposing (testSuite)

import App.Sample exposing (sum, product)
import ElmTest exposing (Test, test, suite, assertEqual)
import Check exposing (Claim, Evidence, claim, that, is, true, for, quickCheck)
import Check.Producer exposing (filter, tuple, int, float)
import Check.Test exposing (evidenceToTest)


testSuite : Test
testSuite =
    suite "App.Sample"
        [ suite "sum"
            [ test "should return a sum of 2 Ints" <|
                assertEqual 8 (sum 3 5)
            , test "should return a sum of 2 Floats" <|
                assertEqual -10.5 (sum -20.5 10)
            ]
        , evidenceToTest
            << quickCheck
          <|
            Check.suite "product"
                [ for (is (that (claim "should multiply Ints") (\( a, b ) -> product a b)) (\( a, b ) -> a * b)) (tuple ( int, int ))
                , for (is (that (claim "should multiply Floats") (\( a, b ) -> product a b)) (\( a, b ) -> a * b)) (tuple ( float, float ))
                , for (true (claim "should be inverted by division with minimal imprecision") (\( a, b ) -> abs (product a b / b - a) < 1.0e-6)) (filter (\( a, b ) -> b /= 0) (tuple ( float, float )))
                ]
        ]
