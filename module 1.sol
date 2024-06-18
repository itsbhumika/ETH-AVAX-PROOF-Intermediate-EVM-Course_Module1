// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract trafficManagement {
    struct vehicle {
        string name;
        uint nWheels;
        uint lengthOfVehicle;
        uint pathDistance;
    }

    mapping(address => vehicle) map;
    // structure vehicle's instance v to hold vehicle details
    vehicle v;

        // Function to add user information of the vehicle
    function putDetails(string memory _name, uint _nwheels, uint _length, uint _path) public {
        // Ensure that the number of wheels is between 1 to 6
        require(_nwheels>1 && _nwheels<=6 , "Road is for commercial and city related use , no highway vehicles are allowed ");

        // Add user information
        v = vehicle(_name,_nwheels,_length,_path);
        map[msg.sender] =v;
    }

    //function to selecting the optimal path based on condition given in if
    function selectPath(uint alterDistance, uint mainCount, uint alterCount) public view returns (string memory){
        if(v.pathDistance <=alterDistance || mainCount<=alterCount){
            revert("You should use the main path only");
        }
        else {
            return "You should use the alternate path";
        }
    }

    //function to check that the selected path should not be commercial 
    function pathCheck(string memory pathDetail) public view returns(string memory) {
        assert(keccak256(abi.encodePacked(pathDetail)) != keccak256(abi.encodePacked("commercial")) && v.lengthOfVehicle<=2);

        return "You can use this path , since it is not commercial";
    }

    //function to vehicle details
    function getUserInfo() public view returns (string memory name, uint nWheels,uint lengthOfVehicle,uint pathDistance) {
        vehicle memory a = map[msg.sender];
        return (a.name, a.nWheels, a.lengthOfVehicle, a.pathDistance);
    }
}