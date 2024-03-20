
//SPDX-License-Identifier:GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Crowdfunding {
    address public projectOwner;
    uint public fundingGoal;
    uint public totalAmountRaised;
    bool public fundingGoalReached;
    mapping(address => uint) public contributions;

    constructor() {
        projectOwner = msg.sender;
        fundingGoal = 100 ether;
        fundingGoalReached = false;
    }

    function donate() public payable {
        require(!fundingGoalReached, "Funding goal reached");
        require(msg.value > 0, "contribution less than 1 ether");

        contributions[msg.sender] += msg.value;
        totalAmountRaised += msg.value;

        if (totalAmountRaised >= fundingGoal) {
            fundingGoalReached = true;
        }
    }

    function withdrawFunds() public {
        require(msg.sender == projectOwner, "You are not project owner");
        require(fundingGoalReached, "Goal reached...Thank you");

        payable(projectOwner).transfer(address(this).balance);
    }

    function reclaimContribution() public {
        require(fundingGoalReached == false, "Goal reached cant reclaim");
        require(contributions[msg.sender] > 0, "You have not contributed");

        uint amountToRefund = contributions[msg.sender];
        contributions[msg.sender] = 0;
        totalAmountRaised -= amountToRefund;

        payable(msg.sender).transfer(amountToRefund);
    }
}
