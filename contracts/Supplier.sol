// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import './RawMaterial.sol';

contract Supplier {
    mapping (address => address[]) public supplierRawMaterials;

    constructor() public {}

    function createRawMaterialPackage(
        string memory _description,
        uint _quantity,
        address _transporterAddr,
        address _manufacturerAddr,
        address _tempSupplierAddr
    ) public {
        RawMaterial rawMaterial = new RawMaterial(
            _tempSupplierAddr,
            address(bytes20(sha256(abi.encodePacked(_tempSupplierAddr, block.timestamp)))),
            _description,
            _quantity,
            _transporterAddr,
            _manufacturerAddr
        );
        supplierRawMaterials[_tempSupplierAddr].push(address(rawMaterial));
    }

    function getAllPackages(address _tempAddressSupplier) public view returns(address[] memory) {
        uint len = supplierRawMaterials[_tempAddressSupplier].length;
        address[] memory ret = new address[](len);
        for (uint i = 0; i < len; i++) {
            ret[i] = supplierRawMaterials[_tempAddressSupplier][i];
        }
        return ret;
    }

}