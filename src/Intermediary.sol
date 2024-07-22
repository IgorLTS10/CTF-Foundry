// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../src/HackMeIfYouCan.sol";

contract Intermediary {
    HackMeIfYouCan target;

    constructor(HackMeIfYouCan _target) {
        target = _target;
    }

    function callAddPoint() public {
        target.addPoint();
    }
}
