// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract savaGas {
    uint public n = 5;

    //gas: 4355
    function noCache() external view returns (uint){
        uint tempValue = 0;

        //n will be called for manytimes
        for (uint i = 0; i < n ; i ++ )
        {
            tempValue += i;
        }
        return tempValue;
    }

    //gas: 4864
    function cache() external view returns (uint){
        uint tempValue = 0;

        //memory is sheaper than storage
        uint _n = n;
        for (uint i = 0; i < _n ; i ++ )
        {
            tempValue += i;
        }
        return tempValue;
    }
}