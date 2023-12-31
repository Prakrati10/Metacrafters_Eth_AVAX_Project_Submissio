// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ExceptionHandling {

    function RequireTest (uint a, uint b) public pure {

        require ( a + b < 10, "Ensure that the combined total of the provided numbers remains below 10.");
    }

    function AssertTest (uint c) public pure {
        assert ( c >= 5 );
    }

    function RevertTest (uint d, uint e) public pure {

        if ( d + e > 10) {
            revert ("Please ensure that the sum of the entered numbers does not exceed 10.");
        }
    }
}
