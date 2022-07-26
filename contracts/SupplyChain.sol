// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;
pragma experimental ABIEncoderV2;

import './RawMaterial.sol';
import './Product.sol';

contract SupplyChain {
    address public Owner;

    //Cosntruct
    constructor() public {
        Owner = msg.sender;
    }

    modifier onlyOwner() {
        require(Owner == msg.sender);
        _;
    }
    
    enum roles {
        noRole,
        supplier,
        transporter,
        manufacturer,
        wholesaler
    }

    struct userData {
        string name;
        string userLoc;
        roles role;
        address userAddr;
    }

    mapping (address => userData) public userInfo;
    
    ///////// EVENTS
    event UserRegister(address _address, string name, string userLoc, uint role, address userAddr);
    event sendEvent(address seller, address buyer, address indexed packageAddr, bytes signature, uint indexed timestamp);
    event buyEvent(address buyer, address indexed seller, address packageAddr, bytes signature, uint indexed timestamp);
    event respondEvent(address indexed buyer, address seller, address packageAddr, bytes signature, uint indexed timestamp);

    /////// all components //////////
    function requestProduct(address buyer, address seller, address packageAddr, bytes memory signature) public {
        emit buyEvent(buyer, seller, packageAddr, signature, now);
    }

    function respondToEntity(address buyer, address seller, address packageAddr, bytes memory signature) public {
        emit respondEvent(buyer, seller, packageAddr, signature, now);
    }

    function verify(address p, bytes32 _hashedMessage, uint8 _v, bytes32 _r, bytes32 _s) public pure returns(bool) {
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";
        bytes32 prefixedHashMessage = keccak256(abi.encodePacked(prefix, _hashedMessage));
        return p == ecrecover(prefixedHashMessage, _v, _r, _s);
    }

    function sendPackageToEntity(address buyer, address seller, address packageAddr, bytes memory signature) public {
        emit sendEvent(seller, buyer, packageAddr, signature, now);
    }

    /////////////// Owner //////////

    function registerUser(string memory _name, string memory _loc, uint _role, address _userAddr) public onlyOwner {
        userInfo[_userAddr].name = _name;
        userInfo[_userAddr].userLoc = _loc;
        userInfo[_userAddr].role = roles(_role);
        userInfo[_userAddr].userAddr = _userAddr;

        emit UserRegister(_userAddr, _name, _loc, _role, _userAddr);
    }

    function getUserInfo(address _address) public view returns(
        userData memory
        ) {
        return userInfo[_address];
    }

    /////////////// Supplier //////////////////////

    mapping (address => address[]) supplierRawMaterials;
    modifier onlySupplier() {
        require(userInfo[msg.sender].role == roles.supplier,"Supplier can use this function");
        _;
    }

    function createRawMaterialPackage(
        string memory _description,
        uint _quantity,
        address _transporterAddr,
        address _manufacturerAddr
        ) public onlySupplier {

        RawMaterial rawMaterial = new RawMaterial(
            msg.sender,
            address(bytes20(sha256(abi.encodePacked(msg.sender, block.timestamp)))),
            _description,
            _quantity,
            _transporterAddr,
            _manufacturerAddr
        );
        supplierRawMaterials[msg.sender].push(address(rawMaterial));
    }

    function getAllPackages() public view returns(address[] memory) {
        uint len = supplierRawMaterials[msg.sender].length;
        address[] memory ret = new address[](len);
        for (uint i = 0; i < len; i++) {
            ret[i] = supplierRawMaterials[msg.sender][i];
        }
        return ret;
    }

    ///////////////  Transporter ///////////////
    modifier onlyTransporter() {
        require(userInfo[msg.sender].role == roles.transporter,"Only Transporter can call this function");
        _;
    }

    modifier validTypeTransporter(uint _transporterType ) {
        require(_transporterType > 0,"Transporter Type is incorrect");
        _;
    }
    function transporterHandlePackage(
        address _address,
        uint _transporterType
        ) public onlyTransporter validTypeTransporter(_transporterType) {
        
        if(_transporterType == 1) { 
            /// Supplier -> Manufacturer
            RawMaterial(_address).pickupPackage(msg.sender);
        }else if(_transporterType == 2) { 
            /// Manufacturer -> Wholesaler
            Product(_address).pickItemProduct(msg.sender);
        }
    }

 

     ///////////////  Manufacturer ///////////////
    mapping (address => address[]) public manufacturerRawMaterials;
    mapping (address => address[]) public manufacturerProducts;

    function manufacturerReceivedRawMaterials(address _addr, address _tempAddrManufacturer ) public {
        require(userInfo[_tempAddrManufacturer].role == roles.manufacturer, "Only Manufacturer can access this function");
        RawMaterial(_addr).receivedPackage(_tempAddrManufacturer);
        manufacturerRawMaterials[_tempAddrManufacturer].push(_addr);
    }


    modifier onlyManufacturer() {
        require(userInfo[msg.sender].role == roles.manufacturer,"Only Manufacturer can create ItemProducto");
        _;
    }

    


}