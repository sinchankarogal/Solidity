// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract StudentGradingSystem {
    struct Grade {
        uint assignmentGrade;
        uint examGrade;
        bool gradeSubmitted;
    }

    mapping(address => Grade) public studentGrades;

    function submitGrade(uint _assignmentGrade, uint _examGrade) public {
        require(_assignmentGrade <= 100 && _examGrade <= 100, "Grades must be between 0 and 100");

        Grade storage studentGrade = studentGrades[msg.sender];
        studentGrade.assignmentGrade = _assignmentGrade;
        studentGrade.examGrade = _examGrade;
        studentGrade.gradeSubmitted = true;
    }

    function getStudentGrade() public view returns (uint assignmentGrade, uint examGrade, bool gradeSubmitted) {
        Grade memory studentGrade = studentGrades[msg.sender];
        return (studentGrade.assignmentGrade, studentGrade.examGrade, studentGrade.gradeSubmitted);
    }
}
