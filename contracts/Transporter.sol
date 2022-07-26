// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import './RawMaterial.sol';
import './Product.sol';

contract Transporter {
    address add;
    function material(address payable _addr) public payable{
        RawMaterial(_addr).pickupPackage(msg.sender);
    }
    
    function handlePackage(
        address _addr,
        uint _transportertype,
        address _tempTransporterAddr
        ) public {

        if(_transportertype == 1) { 
            /// Supplier -> Manufacturer
            RawMaterial(_addr).pickupPackage(_tempTransporterAddr);
        }else if(_transportertype == 2) { 
            /// Manufacturer -> Wholesaler
            Product(_addr).pickItemProduct(_tempTransporterAddr);
        }
    }
    
    
    
}