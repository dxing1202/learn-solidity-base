// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title 复杂值类型
 */
contract ComplexValueType {
    // 测试 address
    function addressTest() public view returns(address){
        // 获取调用合约者的地址
        address owner = msg.sender;
        return owner;
    }

    function thisAddressTest() public view returns(address){
        // 获取本合约的地址
        address thisAddress = address(this);
        return thisAddress;
    }

    // 测试 contract
    function contractTest() public view {
        ComplexValueType mycontract = this;
    }

    // 测试 bytes
    function fixedByteArrayTest() public pure returns(bytes1){
        // bytes3 data; // 0x000000
        bytes3 data = 0x111111;
        bytes1 first = data[0];
        // uint256 l = data.length; // 获取长度
        return first; // 0x11
    }
}