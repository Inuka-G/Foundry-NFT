// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;
import {Test} from "forge-std/Test.sol";
import {DeployBasicNFT} from "../script/DeployBasicNFT.s.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract BasicNFTtest is Test {
    address public USER = makeAddr("inukaG");
    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    DeployBasicNFT public deployBasicNFT;
    BasicNFT public basicNFT;

    function setUp() public {
        deployBasicNFT = new DeployBasicNFT();
        basicNFT = deployBasicNFT.run();
    }

    function testBasicNFTName() public {
        string memory TokenName = basicNFT.name();
        string memory expected = "Doggie";
        assertEq(
            keccak256(abi.encodePacked(TokenName)),
            keccak256(abi.encodePacked(expected))
        );
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(USER);
        basicNFT.mintNft(PUG_URI);
        assertEq(basicNFT.balanceOf(USER), 1);
    }
}
