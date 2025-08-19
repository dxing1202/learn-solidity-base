// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

// 完整的 Permit2 接口定义
interface IPermit2 {
    struct TokenPermissions {
        address token;
        uint256 amount;
    }
    
    struct PermitTransferFrom {
        TokenPermissions permitted;
        uint256 nonce;
        uint256 deadline;
    }
    
    struct Signature {
        uint8 v;
        bytes32 r;
        bytes32 s;
    }
    
    function permitTransferFrom(
        PermitTransferFrom calldata permit,
        Signature calldata signature,
        address owner,
        address to,
        uint256 amount
    ) external;
}

contract Wallet {
    using SafeERC20 for IERC20;

    address public immutable founder;
    IPermit2 public immutable permit2;
    
    event DepositETH(address indexed from, uint256 amount);
    event DepositERC20(address indexed from, address token, uint256 amount);
    event Withdrawal(address indexed to, uint256 amount);

    modifier onlyFounder() {
        require(msg.sender == founder, "Unauthorized: Only founder");
        _;
    }

    constructor(address _permit2Address) {
        founder = msg.sender;
        permit2 = IPermit2(_permit2Address); // 使用主网地址: 0x000000000022D473030F116dDEE9F6B43aC78BA3
    }

    // 接收 ETH 存款
    receive() external payable {
        emit DepositETH(msg.sender, msg.value);
    }

    // 使用 Permit2 签名进行 ERC20 转账
    function transferWithPermit(
        PermitTransferFrom calldata permit,
        Signature calldata signature,
        address tAddress,
        uint256 amount
    ) external {
        // 验证金额是否匹配
        require(permit.permitted.amount == amount, "Invalid amount");
        
        // 使用 Permit2 授权转移代币
        permit2.permitTransferFrom(
            permit,
            signature,
            msg.sender,     // 代币所有者
            // address(this),   // 接收地址
            tAddress,
            amount
        );
        
        emit DepositERC20(msg.sender, permit.permitted.token, amount);
    }

    // 创始人提取 ETH
    function withdrawETH(address payable recipient) external onlyFounder {
        uint256 balance = address(this).balance;
        require(balance > 0, "No ETH balance");
        
        (bool success, ) = recipient.call{value: balance}("");
        require(success, "ETH transfer failed");
        
        emit Withdrawal(recipient, balance);
    }

    // 创始人提取 ERC20 代币
    function withdrawERC20(address token, address recipient) external onlyFounder {
        uint256 balance = IERC20(token).balanceOf(address(this));
        require(balance > 0, "No token balance");
        
        IERC20(token).safeTransfer(recipient, balance);
        
        emit Withdrawal(recipient, balance);
    }
}