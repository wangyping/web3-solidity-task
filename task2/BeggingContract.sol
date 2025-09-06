// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/**
 * @title BeggingContract
 * @dev 一个允许用户捐赠以太币，合约所有者可以提取资金的合约
 */
contract BeggingContract {
    // 合约所有者地址
    address public owner;
    
    // 记录每个捐赠者的捐赠金额 mapping(address => uint256)
    mapping(address => uint256) public donations;
    
    // 捐赠事件，记录每次捐赠的地址和金额
    event Donation(address indexed donor, uint256 amount);
    
    // 提现事件
    event Withdrawal(address indexed owner, uint256 amount);
    
    // 修饰符：仅合约所有者可以调用
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    // 构造函数，设置合约所有者
    constructor() {
        owner = msg.sender;
    }
    
    /**
     * @dev 允许用户向合约发送以太币，并记录捐赠信息
     */
    function donate() public payable {
        require(msg.value > 0, "Donation amount must be greater than 0");
        
        // 记录捐赠信息
        donations[msg.sender] += msg.value;
        
        // 触发捐赠事件
        emit Donation(msg.sender, msg.value);
    }
    
    /**
     * @dev 允许查询某个地址的捐赠金额
     * @param donor 捐赠者地址
     * @return 捐赠金额
     */
    function getDonation(address donor) public view returns (uint256) {
        return donations[donor];
    }
    
    /**
     * @dev 允许合约所有者提取所有资金
     */
    function withdraw() public onlyOwner {
        uint256 amount = address(this).balance;
        require(amount > 0, "No funds to withdraw");
        
        // 将所有资金转移给合约所有者
        payable(owner).transfer(amount);
        
        // 触发提现事件
        emit Withdrawal(owner, amount);
    }
    
    /**
     * @dev 接收以太币的回调函数
     */
    receive() external payable {
        donate();
    }
}
