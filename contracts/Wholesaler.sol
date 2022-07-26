// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import './Product.sol';

contract Wholesaler {
    
    mapping(address => address[]) public productsAtWholesaler;
    
    constructor() public {}
    
    function productRecievedAtWholesaler(
        address _address,
        address _tempAddressWholesaler
    ) public {
        Product(_address).receivedProduct(_tempAddressWholesaler);
        productsAtWholesaler[_tempAddressWholesaler].push(_address);
        
    }

    function getAllProductsAtWholesaler(address _tempAddressWholesaler) public view returns(address[] memory) {
        uint len = productsAtWholesaler[_tempAddressWholesaler].length;
        address[] memory ret = new address[](len);
        for (uint i = 0; i < len; i++) {
            ret[i] = productsAtWholesaler[_tempAddressWholesaler][i];
        }
        return ret;
    }
}