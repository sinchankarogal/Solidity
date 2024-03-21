// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract OrganDonation{
    struct Person {
        address Address;
        string bloodType;
        bool OrganDonor;
        bool Recipient;
    }

    mapping(address => Person) public people;
    Person[] public allPeople;

    function Donor(string memory _bloodType) public {
        require(!people[msg.sender].Recipient, "Is a recipient");
        
        Person memory newPerson = Person(msg.sender, _bloodType, true, false);
        people[msg.sender] = newPerson;
        allPeople.push(newPerson);
    }

    function Recipient(string memory _bloodType) public {
        require(!people[msg.sender].OrganDonor, "Is a donor");
        
        Person memory newPerson = Person(msg.sender, _bloodType, false, true);
        people[msg.sender] = newPerson;
        allPeople.push(newPerson);
    }

    function updateOrganDonorStatus(bool _isOrganDonor) public {
        require(people[msg.sender].Address != address(0), "Not found");
        people[msg.sender].OrganDonor = _isOrganDonor;
    }

   function donorsForBloodType(string memory _bloodType) public view returns (address[] memory) {
    uint count = 0;
    for (uint i = 0; i < allPeople.length; i++) {
        if (keccak256(abi.encodePacked(allPeople[i].bloodType)) == keccak256(abi.encodePacked(_bloodType)) && allPeople[i].OrganDonor) {
            count++;
        }
    }

    address[] memory donors = new address[](count);
    count = 0;
    for (uint i = 0; i < allPeople.length; i++) {
        if (keccak256(abi.encodePacked(allPeople[i].bloodType)) == keccak256(abi.encodePacked(_bloodType)) && allPeople[i].OrganDonor) {
            donors[count] = allPeople[i].Address;
            count++;
        }
    }
    
    return donors;
}

}
