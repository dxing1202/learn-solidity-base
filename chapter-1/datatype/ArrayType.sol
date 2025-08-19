// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract ArrayType{
    // 成员变量都是存储在storage中的
    uint8[3] staticData; // 静态数组
    uint8[] dynamicData; // 动态数组
    // 加一个i变量 为了测试弹出的时候是哪个 前面或者后面
    uint8 i;

    // public/external外部只能用memory internal/private内部调用可以用storage
    function staticArrayTest() public returns(uint8[3] memory){
        // uint8 ele = staticData[0]; // 下标取值
        staticData[0] = 25; // 根据下标赋值 这里有写入逻辑view必须去掉
        // 写入逻辑的函数无法return
        return staticData; // uint8[3]: 0,0,0
    }

    // 读静态数组
    function getStaticArray() public view returns(uint8[3] memory){
        return staticData;
    }

    // 写动态数组
    function dynamicStorageArrayTest() public {
        // 插入一条数据
        dynamicData.push(10 + i);
        i++;
    }

    // 读动态数组
    function getDynamicArray() public view returns(uint8[] memory){
        return dynamicData;
    }

    // 弹出数组数据
    function popDynamicArray() public {
        // 弹出一个 从最后一个开始弹， 如无数据会报错
        dynamicData.pop(); 
    }

    function memoryDynamicArrayTest(uint8 size) public pure returns(uint8[] memory){
        // 内存动态数组初始化
        // 初始化后动态数组定义好后成固定数组长度 也可称为静态数组
        // 内存数组 无法使用 push/pop
        uint8[] memory memoryData = new uint8[](size);
        return memoryData;
    }
}