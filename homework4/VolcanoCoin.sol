// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

/**
 * VolcanoCoin - homework4
 */
contract VolcanoCoin {
    uint256 public supply;
    address owner;

    mapping(address => uint256) public balances;
    mapping(address => Payment[]) payments;
    
    function getSupply()  public view returns (uint) {
        return supply;
    }
    
    
    function increaseSupply() public onlyOwner {
        supply = supply + 1000;
    }
    
    struct Payment {
        address recipient;
        uint amount;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You must be the owner");
        _;
    }
    
    constructor() {
        supply = 10000;
        owner = msg.sender;
        balances[msg.sender] = supply;
    }
    
    event supplyUpdate(uint256);
    event Transfer(address indexed, uint256);
    
    function setSupply (uint new_supply) public onlyOwner {
        supply = new_supply;
        emit supplyUpdate(new_supply);
    }

    function transfer(uint _amount, address _recipient) public {
        require(balances[msg.sender] >= _amount, "Insufficient Balance");
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        
        emit Transfer(_recipient, _amount);
        Payment memory payment;
        payment.recipient = _recipient;
        payment.amount = _amount;
        payments[msg.sender].push(payment);
    }
    
    function getPayments(address _user) public view returns (Payment[] memory) {
        return payments[_user];
    }
}
