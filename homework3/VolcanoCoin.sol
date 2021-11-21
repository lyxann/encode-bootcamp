// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

/**
 * VolcanoCoin - homework3
 */
contract VolcanoCoin {
    uint public supply = 10000;
    
    function getSupply()  public view returns (uint) {
        return supply;
    }
    
    
    function increaseSupply() public onlyOwner {
        supply = supply + 1000;
    }
    
    address public owner;
    
    modifier onlyOwner {
        if (msg.sender == owner) {
            _;
        }
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    event Supply_update(uint);
    
    function setSupply (uint new_supply) public onlyOwner {
        supply = new_supply;
        emit Supply_update(new_supply);
    }
            
}
