// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title ContractStructure
 * @dev structure function test
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract ContractStructure{
    // 默认 uint的值为0
    uint256 public balance;
    // 默认 string的值为空 ''
    string  public name;

    // 定义事件 余额增加
    event BalanceAdded(uint256 oldValue, uint256 incre);

    constructor(uint256 _bal){
        balance = _bal;
    }

    // 定义 函数修饰器/函数修改器
    // 增量范围
    modifier incrementRange(uint256 _incre) {
        // 修饰器是对函数的输入输出条件进行约束的
        require(_incre > 100, "too small!");
        _; // 执行被修饰函数的逻辑
    }

    // 上面的状态变量编译后相当于下面的函数 可以直接在合约外部访问balance的值
    // 函数不能有和状态变量同名
    // uint 默认为 uint256
    // function balance() public view returns(uint) {
    //     return balance;
    // }

    function balance1() public view returns (uint){
        // balance 状态变量就算是private也可以通过public函数对外使用
        return balance;
    }

    // 写代码的时候一定要想一想这个执行是否需要上区块链
    // 不然上链需要gas费用高以及需要等待时间矿工处理完成后回调
    // 不改变状态变量的函数可以去加上 view 或者 prue
    // view 为读的操作
    // prue 为状态变量无关的函数

    function addBalance(uint256 _incre) external incrementRange(_incre) { // 修饰器使用
        uint256 old = balance;
        balance += _incre;
        emit BalanceAdded(old,_incre);
    }

}