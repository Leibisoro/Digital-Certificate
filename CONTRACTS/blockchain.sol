// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract DigitalCertificate {
   
    mapping (address => Certificate[]) public studentCertificates;

    
    struct Certificate {
        string courseName;
        string institution;
        uint256 graduationDate;
        bool isValid;
    }

    
    event NewCertificate(address indexed student, string courseName, string institution, uint256 graduationDate);

    function issueCertificate(address student, string memory courseName, string memory institution, uint256 graduationDate) public {
       
        Certificate memory newCertificate = Certificate(courseName, institution, graduationDate, true);

        studentCertificates[student].push(newCertificate);

        
        emit NewCertificate(student, courseName, institution, graduationDate);
    }

 
    function verifyCertificate(address student, string memory courseName) public view returns (bool) {
        
        for (uint256 i = 0; i < studentCertificates[student].length; i++) {
            if (keccak256(abi.encodePacked(studentCertificates[student][i].courseName)) == keccak256(abi.encodePacked(courseName))) {
                return studentCertificates[student][i].isValid;
            }
        }

        
        return false;
    }
}