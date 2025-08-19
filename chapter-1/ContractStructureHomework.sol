// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract ContractStructureHomework {

    uint256 public zz;

    // 1. 写一个纯函数，输入x和y，返回x + y
    // 这里必须加了pure才能成功编译
    function sumValue(uint256 x, uint256 y) public pure returns (uint256){
        // 这里也可以不用加括号
        return (x+y);
    }

    // 3. 一个正确的pure函数能否修饰成View？View能否修饰（默认）成写操作？有什么结果？反之可以吗？
    // 不能，不能，无法成功编译，反之也不可以
    function getZz() external view returns(uint256){
        return zz;
    }

    // 2. Public的成员变量，能被修改吗？是否生成写操作函数？这一点与java有何不同？
    // 能，是，
    function editZz(uint256 z) external {
        zz = z;
    }
}