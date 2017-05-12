pragma solidity ^0.4.8;

contract ChapterInterface {
    /// Create empty Chapter
    /// @param address _president
    /// @param address _secretary
    /// return Chapter chapter
    function createChapterGlobal([]address _board, address _president, address _secretary) returns (ChapterInterface chapter);

    /// Create empty Chapter
    /// @param address _president
    /// @param address _secretary
    /// return Chapter chapter
    function createChapterNational(address _president, address _secretary) returns (ChapterInterface chapter);

    /// Create empty Chapter
    /// @param address _president
    /// @param address _secretary
    /// return Chapter chapter
    function createChapterLocal(address _president, address _secretary) returns (ChapterInterface chapter);

    /// Set chapter executive committee
    /// @param address[] _executives
    /// @return bool
    function setExecutiveCommittee(uint24[3] _chapterId, address[] _executives) returns (bool success);

    /// Set chapter forum
    /// @param uint24[3] chapterId
    /// @param Forum forum
    /// @return bool
    function setForum(uint24[3] _chapterId, address[] _members) public returns(bool success);

    /// Set chapter Secretariat
    /// @param address _secretary
    /// @param address[] _members
    /// @return bool
    function setSecretariat(uint24[3] _chapterId, address _secretary, address[] _members) returns (bool success);

    /// Set chapter president
    /// @param uint24[3] chapterId
    /// @param ExecutiveCommittee executiveCommittee
    /// @return address executiveCommitteeAddr
    function setNewPresident(uint24[3] _chapterId, address _president) returns (bool success);

    /// Set new secretary
    function setNewSecretary(uint24[3] _chapterId, address _secretary) returns (bool success);
}