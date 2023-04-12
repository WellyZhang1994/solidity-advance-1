// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract sendEther {

    constructor() payable {

    }

    //transfer and send need to use address payable rather than address
    function sendViaTransfer(address payable _to) public payable {
        //2300 gas limit for address
        //transfer did not return anything
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        //send returns a boolean value for success or failure.
        //2300 gas limit for address 
        bool sent = _to.send(msg.value);
        require(sent, "fail");
    }

    function sendViaCall(address _to) public payable {
        //call returns a boolean value for success or failure.
        //no gas limitation
        //value -> number: transfer ether by contract balance
        //value -> msg.value transfer ether by sender
        //value -> address(this).balance: transfer all ether by contract balance
        (bool sent, ) = _to.call{value: 10}("");
        require(sent, "fail");
    }
}