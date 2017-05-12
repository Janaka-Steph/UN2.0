pragma solidity ^0.4.8;

// import './Legislator.sol';
import './ChapterInterface.sol';

contract ChapterController is ChapterInterface {

    function createChapter(address _president, address _secretary) returns (ChapterInterface chapter) {
        // switch type
        // get ChapterDatabase
        // return ChapterDatabase.createChapter(_chapterId, _president, _secretary)
    }

    //function createChapterGlobal(_currentChapter) is('boardOfDirectors') returns (chapter) {}
    //function createChapterNational(_currentChapter) is('boardOfDirectors') returns (chapter) {}
    //function createChapterLocal(_currentChapter) is('boardOfDirectors') returns (chapter) {}


    ///
    function setForum(uint24[3] chapterId, address[] _members) public returns(bool success) {

    }

    // Set executive committee process
    function setExecutiveCommittee() {
        //VotingSystem = ContractProvider(GDAO).getContract(name);
        // Legislator.vote();
        //if (VotingSystem.isPassed) {
           //ChapterDatabase = ContractProvider(GDAO).getContract('chapterDatabase');
           //ChapterDatabase.setExecutiveCommittee();
        //}
    }
}

/*
1. Adopted by: UN2.0 Board of Directors
2. Normative base: Norm 20170101-0000000000-0001-02 relative to UN2.0 norms
3. Date of adoption: 01/01/2017
4. Recipients: any chapter's board of directors
5. Signatory: President of UN2.0
6. Date of signature: 01/01/2017
*/