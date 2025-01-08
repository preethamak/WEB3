
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CrowdFunding{
    string public name;
    string public description;
    uint256 public goal;
    uint256 public deadline;
    address public owner;
    bool public paused;

    enum campaignState{Active, Sucessful, Failed}
    campaignState public state;

    struct tier{
        string name;
        uint256 amount;
        uint256 backers;
    }

    struct backer{
        uint256 totalContribution;
        mapping (uint256=>bool) fundedTier;
    }

    tier[] public tiers;
    mapping(address=>backer) backers;

    modifier OnlyOwner{
        require(msg.sender==owner, "You are not owner ");
        _;
    }

    modifier campOpen{
        require(state==campaignState.Active);
        _;
    }

    modifier notPaused(){
        require(!paused,"contract is paused");
        _;
    }

    constructor(address _owner,
                string memory _name,
                string memory _description,
                uint256 _goal,
                uint256 duration)
                {
        name = _name;
        description = _description;
        goal = _goal;
        deadline = block.timestamp + (duration*1 days);
        owner = _owner;
        state=campaignState.Active;     
    }

    function CheackState() internal {
        if(state==campaignState.Active){
            if(block.timestamp>=deadline){
                state = address(this).balance>=goal? campaignState.Sucessful: campaignState.Failed;
            }
            else{
                 state = address(this).balance>=goal? campaignState.Sucessful: campaignState.Active;
            }
        }
    }

    function fund(uint256 _tierIndex) public payable campOpen notPaused {
        require(_tierIndex<tiers.length,"invalid tier");
        require(msg.value==tiers[_tierIndex].amount, "Amount incorrect ");

        tiers[_tierIndex].backers++;
        backers[msg.sender].totalContribution+=msg.value;
        backers[msg.sender].fundedTier[_tierIndex]=true;
    }

    function addTier(string memory _name, uint256 _amount) public OnlyOwner{
        require(_amount>0, "Amount should be greater than zero" );
        tiers.push(tier(_name, _amount, 0));
    }

    function removeTier(uint256 _index) public OnlyOwner{
        require(_index<tiers.length, "Tier does not exists ");
        tiers[_index] = tiers[tiers.length-1];
        tiers.pop();
    }
   function withdraw() public OnlyOwner{
        CheackState();
        require(state==campaignState.Sucessful, "campaign not sucessful yet");
        uint balance = address(this).balance;
        require(balance>0, "Balance should be greater than 0$");
        payable(owner).transfer(balance);

    }

    function Balance() public view returns(uint256){
        return address(this).balance;
    }

    function refund() public {
        CheackState();
        require(state==campaignState.Failed,"Refund not possible");
        uint256 amount = backers[msg.sender].totalContribution;
        require(amount>0, "You have not funded anyhting ");


        backers[msg.sender].totalContribution = 0;
        payable(msg.sender).transfer(amount);
    }

    function hasFunded(address _backers, uint256 _tierIndex) public view returns(bool) {
        return backers[_backers].fundedTier[_tierIndex];
    }

    function getTier() public view returns(tier[] memory){
        return tiers;
    }

    function togglePaused() public OnlyOwner{
        paused = !paused;
    }

    function getStatus() public view returns(campaignState){
        if(state==campaignState.Active && block.timestamp>deadline){
            return address(this).balance >= goal? campaignState.Sucessful: campaignState.Failed;
        }
        return state;
    }

    function extend(uint256 _daysToAdd) public OnlyOwner campOpen{
        deadline+=_daysToAdd*1 days;
    }
}