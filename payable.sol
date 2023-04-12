// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Payable {
    // Payable address can receive Ether
    address payable public owner;

    constructor() payable {
        owner = payable(msg.sender);
    }

    //can send the ether by value, and use msg.value to get the ether value
    //the minimum ether unit is wei
    function deposit() public payable {}

    function notPayable() public {}

    // Function to withdraw all Ether from this contract.
    function withdraw() public {
        // get the amount of Ether stored in this contract
        uint amount = address(this).balance;
        // send all Ether to owner
        // Owner can receive Ether since the address of owner is payable
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    function transfer(address payable _to, uint _amount) public {
        // Note that "to" is declared as payable
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }
}