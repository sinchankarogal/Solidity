// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

contract MyString{
    string store="abcdef";

    function getstore() public view returns(string memory){
        return store;
    }

    function setStore(string memory _value) public{
        store=_value;
    }
}
