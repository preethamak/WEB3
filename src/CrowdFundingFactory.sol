// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CrowdFunding} from "./CrowdFunding.sol";

contract CrowdFundingFactory{
    address public owner;
    bool public paused;

    struct camp{
        address campAddress;
        address owner;
        string name;
        uint256 creationTime;
    }

    camp[] public camps;
    mapping (address => camp[]) public userCamp;

    modifier onlyOwner(){
        require(msg.sender==owner, "You are not owner ");
        _;
    }

    modifier isPaused(){
        require(!paused, "Funding is paused");
        _;
    }

    constructor(){
        owner==msg.sender;
    }

    function createCamp(
        string memory _name,
        string memory _description, 
        uint256 _goal, 
        uint256 _duration
    ) external isPaused{
        CrowdFunding newCamp = new CrowdFunding(
            msg.sender,
            _name,
            _description, 
            _goal, 
            _duration
        );
        address campAddress = address(newCamp);
        camp memory campagin = camp({
            campAddress:campAddress,
            owner:msg.sender,
            name:_name,
            creationTime:block.timestamp
        });
        camps.push(campagin);
        userCamp[msg.sender].push(campagin);
    }

    function getUserCamp(address _user) external view returns(camp[] memory){
        return userCamp[_user];
    }

    function getAllCamp() external  view returns(camp[] memory){
        return camps;
    }

    function togglePaused() external  onlyOwner{
        paused=!paused;
    }
}
