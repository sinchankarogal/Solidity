// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

contract Types{
    function getCallerAddress() public view returns(address caller){
        caller=msg.sender;
    }

    function setAddress(address _x) public pure returns (address caller1){
        caller1=_x;
    }
}
