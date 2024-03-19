// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract CrowdFunding {
    enum ProjectStatus { Active, Closed }

    struct Project {
        string description;
        uint goalAmount;
        uint currentAmount;
        address owner;
        ProjectStatus status;
    }

    Project[] public projects;
    uint public constant CONTRIBUTION_AMOUNT = 100;

    function createProject(string memory _description, uint _goalAmount) public {
        projects.push(Project(_description, _goalAmount, 0, msg.sender, ProjectStatus.Active));
    }

    function contribute(uint _index) public payable {
        require(_index < projects.length, "Invalid project index");
        require(projects[_index].status == ProjectStatus.Active, "Project is not active");

        projects[_index].currentAmount += CONTRIBUTION_AMOUNT;
    }

    function withdrawFunds(uint _index) public {
        require(_index < projects.length, "Invalid project index");
        require(projects[_index].status == ProjectStatus.Active, "Project is not active");
        require(projects[_index].currentAmount >= projects[_index].goalAmount, "Funding goal not reached");

        payable(projects[_index].owner).transfer(projects[_index].currentAmount);
        projects[_index].status = ProjectStatus.Closed;
    }

    function reclaimContribution(uint _index) public {
        require(_index < projects.length, "Invalid project index");
        require(projects[_index].status == ProjectStatus.Active, "Project is not active");
        require(projects[_index].owner != msg.sender, "Owner cannot reclaim contribution");

        uint contribution = projects[_index].currentAmount;
        projects[_index].currentAmount = 0;
        payable(msg.sender).transfer(contribution);
    }

    function getProjectStatus(uint _index) public view returns (ProjectStatus) {
        require(_index < projects.length, "Invalid project index");
        return projects[_index].status;
        
    }
}
