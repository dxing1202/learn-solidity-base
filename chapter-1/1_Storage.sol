// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Storage {
    // 整型无符号256位
    uint256 number;
    string message = "hello world";
    // 地址数据类型
    address public owner = msg.sender;

    // 读操作
    function getMessage() public view returns(string memory) {
        return message;
    }

    // 写操作
    // 这里执行部署后出现黄色提示，暂时还不知道什么原因。 红色提示一样可以部署成功执行
    function setMessage(string memory msg) public {
        message = msg;
    }

    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function store(uint256 num) public {
        number = num;
    }

    /**
     * @dev Return value 
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256){
        return number;
    }
}