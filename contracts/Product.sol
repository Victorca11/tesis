// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import './Transactions.sol';

contract Product {

    address Owner;

    enum productStatus {
        atManufacturer,
        pickedForW,
        pickedForD,
        deliveredAtW,
        deliveredAtD,
        pickedForC,
        deliveredAtC
    }

    string description;
    address[] rawMaterials;
    address[] transporters;
    address manufacturer;
    address wholesaler;
    address customer;
    uint quantity;
    productStatus status;
    address txnContractAddress;

    event ShippmentUpdate(
        address indexed BatchID,
        address indexed Shipper,
        address indexed Receiver,
        uint TransporterType,
        uint Status
    );

    constructor(
        address _manufacturerAddr,
        string memory _description,
        address[] memory _rawAddr,
        uint _quantity,
        address[] memory _transporterAddr,
        address _receiverAddr
    ) public {
        Owner = _manufacturerAddr;
        manufacturer = _manufacturerAddr;
        description = _description;
        rawMaterials = _rawAddr;
        quantity = _quantity;
        transporters = _transporterAddr;
        wholesaler = _receiverAddr;
        status = productStatus(0);
        Transactions txnContract = new Transactions(_manufacturerAddr);
        txnContractAddress = address(txnContract);
    }

    function receivedProduct( address _receiverAddr) public returns(uint){
        require(
            _receiverAddr == wholesaler,
            "Only Wholesaler can call this function"
        );

        require(
            uint(status) >= 1,
            "Product not picked up yet"
        );

        if(status == productStatus(1)){
            status = productStatus(3);
            emit ShippmentUpdate(address(this), transporters[transporters.length - 1], wholesaler, 2, 3);
            return 1;
        }
        return 0;
    }

    function pickItemProduct(
        address _transporterAddr
    ) public {
        require(
            _transporterAddr == transporters[transporters.length - 1],
            "Only Transporter can call this function"
        );
        require(
            status == productStatus(0),
            "Package must be at Manufacturer."
        );

        if(wholesaler != address(0x0)){
            status = productStatus(1);
            emit ShippmentUpdate(address(this), _transporterAddr, wholesaler, 1, 1);
        }
    }

    function getItemProductTxn() public view returns(address){
        return txnContractAddress;
    }



}