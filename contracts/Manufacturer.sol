// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import './RawMaterial.sol';
import './Product.sol';

contract Manufacturer{

    mapping (address => address[]) public manufacturerRawMaterials;
    mapping (address => address[]) public manufacturerProducts;

    constructor() public {}
     
    function manufacturerReceivedPackage(
        address _addr,
        address _manufacturerAddress
        ) public {
            
        RawMaterial(_addr).receivedPackage(_manufacturerAddress);
        manufacturerRawMaterials[_manufacturerAddress].push(_addr);
    }

    function manufacturerCreatesProducto(
        address _manufacturerAddr,
        string memory _description,
        address[] memory _rawAddr,
        uint _quantity,
        address[] memory _transporterAddr,
        address _recieverAddr
        ) public {
        Product _product = new Product(
            _manufacturerAddr,
            _description,
            _rawAddr,
            _quantity,
            _transporterAddr,
            _recieverAddr
        );

        manufacturerProducts[_manufacturerAddr].push(address(_product)); 
    }

    function getAllProducts(address _tempAddressManufacturer) public view returns(address[] memory) {
        uint len = manufacturerProducts[_tempAddressManufacturer].length;
        address[] memory ret = new address[](len);
        for (uint i = 0; i < len; i++) {
            ret[i] = manufacturerProducts[_tempAddressManufacturer][i];
        }
        return ret;
    }

}
