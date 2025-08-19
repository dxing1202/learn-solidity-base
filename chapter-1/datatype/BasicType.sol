// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract BasicType {
    
    // 测试 整型
    function intTest() public pure returns(uint){
        uint256 i8 = 259887;
        // 获取uint256最大值  uint获取最小值就不用测试了为0没有意义 int的有负值可以进行测试
        uint256 uintMax = type(uint256).max;
        // SafeMath 低版本处理溢出问题
        // i8++;
        uint8 x = 8;
        uint16 y = 256; 
        // x = y; // 这样赋值失败 由于x的数据类型是uint8 小于y的数据类型
        // y = x; // 这样赋值可以
        x = uint8(y); // 自己显式强制转换可以赋值 y的值超过转换类型uint8的值会为0
        return x;
    }

    // 测试 枚举
    enum OrderState{layorder, payment}
    function enumTest() public view returns(OrderState){
        OrderState state = OrderState.layorder;
        return state;
    }
}