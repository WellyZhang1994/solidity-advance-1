// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract functionSelector {
    /*
    "transfer(address,uint256)"
    0xa9059cbb
    * can not use "uint" only, need to use uint256
    */
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
}

contract logFunc {
    event Log(bytes data);
    function transfer(address from, uint amount) external {
        //msg.data as below
        //0xa9059cbb => function selector
        //0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4 => address from value
        //000000000000000000000000000000000000000000000000000000000000000a => uint amount value
        emit Log(msg.data);
    }
}