pragma solidity ^0.4.8;

contract RightManagement {
    enum Level {Local, National, Global};
    enum Roles {President, Secretary, SecretariatAgent, Moderator, CourtMember, Member};

    permissions mapping(address => identity)

    struct identity {
        bytes32 role;

        // II. Article 50 -	Principle of subsidiarity
        // 1. UN2.0 bodies are ordered in chapters of different levels.
        bytes32 level;

        // II. B.	Organic Principles - Article 51 - Levels
        // 2 [...] Each UN2.0 member can belong to up to a hundred sub-chapters in total.
        bytes10[] public chapterIds;
    }

    struct Chapter {
        bytes3 nationalChapterId
        bytes5 localChapterId
        bytes2 subChapterId
    }
}

contract MyContract {
    modifier areRoleAndContext(_role, _context) {
        bytes32 role = permissions[msg.sender].role;
        bytes32 context = permissions[msg.sender].context;
        if(role == _role && context == _context) _;
        throw;
    }

    function fn1() areRoleAndChapterId('president', '0011000001') {}
}

contract MembersManagement {

    setIdentity(address _address, bytes32 _role, bytes32 _context) {
        // when president, you are moderator of the parent chapter

        permissions[_address] = Identity('president', 'local')
    }
}