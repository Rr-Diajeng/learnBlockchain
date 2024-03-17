// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract HotelRoom{
    

    // Ether payments
    // modifiers
    // visibility
    // events
    // enums

    // status dari kamarnya apakah vacant atau occupied. 
    // menggunakan enum karena isinya gaakan berubah

    enum Statuses {
        Vacant,
        Occupied
    }
    Statuses public currentStatus;

    // pilih mau kamar mana dan harganya
    event Occupy(address _occupant, uint _value);

    // berarti owner yang akan menerima uang transaksi
    address payable public owner;

    constructor(){
        // owner itu yang menerapkan kontrak
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant{
        // check status
        // kalau true, akan lanjut ke other line. kl false, stops
        require(currentStatus == Statuses.Vacant, "Currently occupied");
        
        //return function code
        _;
    }

    modifier costs(uint _amount){
        // check price
        require(msg.value >= _amount, "Not enough ether provided");
        _;
    }

    function book() public payable onlyWhileVacant costs(2 ether){

        // occupied karena uda di book
        currentStatus = Statuses.Occupied;
        // owner akan mendapatkan uang transfer
        owner.transfer(msg.value);
        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        require(true);
        
        emit Occupy(msg.sender, msg.value);
    }


}
