// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract BytesAndString{
    // 初始化方式两种 1.直接赋值 2. new string(5) 或者 new bytes(5)
    string name = "BytesAndString"; // new string(5)
    bytes name1 = "BytesAndString1"; // new bytes(5)

    // string是不能修改的，bytes是可以修改的

    function StringAndBytesTest() public view returns (string memory) {
        // 初始化方式 new 为什么用new？ struct初始化为什么不用new？
        string memory data = "xyz"; // new string(5);
        bytes memory data1 = "abc"; // new bytes(5);

        // 不同localtion的memory拷贝
        data = name; // string
        data1 = name1; // bytes

        // 类型转换
        data = string(data1);
        data1 = bytes(data);
        // 下标访问
        // bytes1 b = data[0];
        // data[0] = 0x88;

        // bytes1 b = data1[0];
        // data1[0] = 0x88;
        // 能够push pop吗
        // name1.push(0x00);
        // data1.push(0x00);

        return data;
    }
    // 高级话题：bytes与bytes1[]的区别...
}