// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import './Transactions.sol';

contract RawMaterial {
    address Owner;

    enum packageStatus { atCreator, picked, delivered }

    address public productid;
    string description;
    uint quantity;
    address transporter;
    address manufacturer;
    address supplier;
    packageStatus status;
    bytes32 packageReceiverDescription;
    address txnContractAddress;

    constructor (
        address _creatorAddr,
        address _productid,
        string memory _description,
        uint _quantity,
        address _transporterAddr,
        address _manufacturerAddr
    ) public {
        Owner = _creatorAddr;
        productid = _productid;
        description = _description;
        quantity = _quantity;
        transporter = _transporterAddr;
        manufacturer = _manufacturerAddr;
        supplier = _creatorAddr;
        status = packageStatus(0);
        Transactions txnContract = new Transactions(_manufacturerAddr);
        txnContractAddress = address(txnContract);
    }


    function getSuppliedRawMaterials () public view returns(
        address,
        string memory,
        uint,
        address,
        address,
        address,
        address
    ) {
        return (productid, description, quantity, supplier, transporter, manufacturer, txnContractAddress);
    }

    function getRawMaterialStatus() public view returns(
        uint
    ) {
        return uint(status);
    }

    function updateManufacturerAddress(address addr) public {
        manufacturer = addr;
    }


    function pickupPackage(
        address _transporterAddr
    ) public {
        require(
            _transporterAddr == transporter,
            "Only transporter of the package can pick package"
        );
        require(
            status == packageStatus(0),
            "Package must be at Supplier."
        );
        status = packageStatus(1);
    }

    
    function receivedPackage(
        address _manufacturerAddr
    ) public {

        require(
            _manufacturerAddr == manufacturer,
            "Only Manufacturer of the package can receieve the package"
        );

        require(
            status == packageStatus(1),
            "Product not picked up yet"
        );
        status = packageStatus(2);
    }




}