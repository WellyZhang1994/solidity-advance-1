// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface IWETH9 {
    function deposit() external payable;
    function withdraw(uint256 _amount) external;
}

contract WETH9 is IWETH9, ERC20 {
    constructor(uint256 initialSupply)  ERC20("WETH9", "WETH9") {
        _mint(msg.sender, initialSupply * 10 ** uint(decimals()));
    }

    function deposit() external payable{
        _mint(msg.sender, msg.value);
        emit Transfer(address(this), msg.sender, msg.value);
    }
    function withdraw(uint256 _amount) external{
        (bool success, ) = msg.sender.call{value: _amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
        _burn(msg.sender, _amount);
    }

    receive() external payable {
        _mint(msg.sender, msg.value);
        emit Transfer(address(this), msg.sender, msg.value);
    }
}