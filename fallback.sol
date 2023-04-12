// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract fallbacks {
    event Log(string func);

    //fallback function must be declared as external.
    fallback() external payable {
        emit Log("fallback");
    }
    receive() external payable {
        emit Log("receive");
    }
}

contract SendToFallback {
    function transferToFallback(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function callFallback(address payable _to) public payable {
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}