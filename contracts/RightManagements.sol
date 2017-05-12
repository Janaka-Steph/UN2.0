pragma solidity ^0.4.8;

contract RightManagement {
    enum Roles {President, Secretary, SecretariatAgent, Moderator, CourtMember, Member}

    struct Identity {
        address addr;
        bytes32 role;
        // II. B.	Organic Principles - Article 51 - Levels
        // 2 [...] Each UN2.0 member can belong to up to a hundred sub-chapters in total.
        bytes10[] belongsToChapterIds;
    }

    struct Chapter {
        bytes3 nationalChapterId;
        bytes5 localChapterId;
        bytes2 subChapterId;
    }

    mapping(address => Identity) public permissions;

    function setIdentity(address _address, Roles _role) returns (bool success) {
        // when president, you are moderator of the parent chapter
        permissions[_address] = Identity(_address, _role, []);
        return true;
    }
}

contract MyContract is RightManagement {

    modifier areRoleAndChapterId(Roles _role) {
        bytes32 role = permissions[msg.sender].role;
        if(role == _role) _;
        throw;
    }

    function fn1() areRoleAndChapterId('president') {}
}