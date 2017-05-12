contract ChapterInterface {
    /// Create empty Chapter
    /// @param bytes10 _chapterId
    /// @param address _president
    /// @param address _secretary
    /// return Chapter chapter
    function createChapter(bytes10 _chapterId, address _president, address _secretary) returns (Chapter chapter);

    /// Set chapter BoardOfDirectors
    /// @param address[] directors
    /// @return bool
    function setBoardOfDirectors(address[] directors) returns (int boardOfDirectors);

    /// Set chapter president
    /// @param bytes10 chapterId
    /// @param ExecutiveCommittee executiveCommittee
    /// @return address executiveCommitteeAddr
    function setChapterPresident(address _president) returns (bool success);

    /// Set chapter executive committee
    /// @param address[] _executives
    /// @return bool
    function setExecutiveCommittee(address[] _executives) returns (bool success);

    /// Set chapter forum
    /// @param bytes10 chapterId
    /// @param Forum forum
    /// @return bool
    function setForum(bytes10 chapterId, Forum _forum) public returns(bool success);

    /// Set chapter Secretariat
    /// @param address _secretary
    /// @param address[] _members
    /// @return bool
    function setSecretariat(address _secretary, address[] _members) returns (bool success);

    /// Set new secretary
    function setNewSecretary(bytes10 chapterId, address _secretary) returns (bool success);
}