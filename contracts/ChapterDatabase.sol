pragma solidity ^0.4.8;

contract ChapterDatabase /*is GDAOEnabled*/ {

   // [1, 1, 1]
   uint24[3] chapterId;

   enum Level {Local, National, Global}

   struct Forum {
       address[] members;
   }
   
   struct ExecutiveCommittee {
      address executiveCommitteeId;
      address[] members;
   }
      
   struct BoardOfDirectors {
      address[] directors;
   }
         
   struct Secretariat {
       address secretary;
       address[] members;
   }
  
   struct Chapter {
    /// @dev Each chapter is composed of a forum, an executive committee, a board of directors and a secretariat
    /// Each chapter is chaired by a president and is managed by a secretary.
    // TODO explain index - https://medium.com/@robhitchens/solidity-crud-part-1-824ffa69509a
    uint index;
    uint24[3] chapterId;
    // II. Article 50 -	Principle of subsidiarity
    // 1. UN2.0 bodies are ordered in chapters of different levels.
    Level level;
    address president;
    Forum forum;
    ExecutiveCommittee executiveCommittee;
    BoardOfDirectors boardOfDirectors;
    Secretariat secretariat;
    uint24[3][] subChapters;
  }

  struct ChapterGlobal {
    uint24 globalChapterId;
    address president;
    Forum forum;
    ExecutiveCommittee executiveCommittee;
    BoardOfDirectors boardOfDirectors;
    Secretariat secretariat;
    mapping(uint24 => ChapterNational) chaptersNational;
  }

  struct ChapterNational {
    uint24 nationalChapterId;
    address president;
    Forum forum;
    ExecutiveCommittee executiveCommittee;
    Secretariat secretariat;
    // moderators
    mapping(uint24 => ChapterLocal) chaptersLocal;
  }

  struct ChapterLocal {
    uint24 localChapterId;
    address president;
    Forum forum;
    ExecutiveCommittee executiveCommittee;
    Secretariat secretariat;
  }

  mapping(uint24 => ChapterGlobal) chaptersGlobal;
  address[] private  chapterIndex;

  event LogChapterBodies (
    address indexed chapterId,
    uint index,
    address forum,
    address executiveCommittee,
    address boardOfDirectors,
    address secretariat,
    address chapterPresident,
    address chapterSecretary
  );
  event LogBody    (address indexed chapterId, uint index, address body);
  event LogChapter (address indexed chapterId, uint index, address chapter);
  event LogUpdateChapter(address indexed chapterId, uint index, bytes32 bodyType, address bodyAddr);




  //////////////////////////////////
  /// Check if chapter exist
  /// @param address chapterId
  /// @return bool isIndeed
  function isExistingChapterLocal(uint24[3] _chapterId)
    public
    constant
    returns(bool isIndeed)
  {
    if (chapterIndex.length == 0) return false;

    // return chapterIndex[chapters[_chapterId].index] == _chapterId;
    // chaptersGlobal[_chapterId[0]].chaptersNational[_chapterId[1]].chaptersLocal[_chapterId[2]];
  }


  /// Create empty Chapter
  /// @param uint24[3] _chapterId
  /// @param address _president
  /// @param address _secretary
  /// return Chapter chapter
  function createChapter(uint24[3] _chapterId, address _president, address _secretary) returns (Chapter chapter) {
    Forum memory newForum = Forum({
      members: []
    });

    ExecutiveCommittee memory newExecutiveCommittee = ExecutiveCommittee({
      executiveCommitteeAddr: -1
    });

    BoardOfDirectors memory newBoardOfDirectors = BoardOfDirectors({
      boardOfDirectorsAddr: -1
    });

    Secretariat memory newSecretariat = Secretariat({
      secretary: _secretary,
      members: []
    });

    // push() returns the new length
    uint index     =  chapterIndex.push(_chapterId) - 1;
    chapters[chapterId] = Chapter(index, _chapterId, _president, newForum, newExecutiveCommittee, newBoardOfDirectors, newSecretariat);
    return chapters[chapterId];
  }

  /// Set chapter forum
  /// @param uint24[3] chapterId
  /// @param Forum forum
  /// @return bool
  function setForum(uint24[3] chapterId, Forum _forum) public returns(bool success) {
    if(!isExistingChapter(chapterId)) throw;
    // Set forum
    chapters[chapterId].forum = _forum;
    // push() returns the new length
    chapters[chapterId].index     =  chapterIndex.push(chapterId) - 1;

    LogBody(
      chapterId,
      chapters[chapterId].index,
      chapters[chapterId].forum
    );

    return true;
  }


  /// Set chapter executive committee
  /// @param address[] _executives
  /// @return bool
  function setExecutiveCommittee(address[] _executives) returns (bool success) {
    if(!isExistingChapter(chapterId)) throw;
      // Set ExecutiveCommittee
      chapters[chapterId].executiveCommittee.executives = _executives;
      LogBody(
        chapterId,
        chapters[chapterId].index,
        chapters[chapterId].executiveCommittee
      );
      return true;
  }

  /// Set chapter BoardOfDirectors
  /// @param address[] directors
  /// @return bool
  function setBoardOfDirectors(uint24[3] _chapterId, address[] _directors) returns (bool success) {
     if(!isExistingChapter(_chapterId)) throw;
     // Set BoardOfDirectors
     chapters[_chapterId].boardOfDirectors.directors = _directors;
     LogBody(
       chapterId,
       chapters[_chapterId].index,
       chapters[_chapterId].boardOfDirectors,
       chapters[_chapterId].boardOfDirectors.directors
     );
    return true;
  }

  /// Set chapter Secretariat
  /// @param address _secretary
  /// @param address[] _members
  /// @return bool
  function setSecretariat(address _secretary, address[] _members) returns (bool success) {
   if(!isExistingChapter(chapterId)) throw;
       // Set Secretariat
       chapters[chapterId].secretariat.secretary = _secretary;
       chapters[chapterId].secretariat.members = _members;
       LogBody(
         chapterId,
         chapters[chapterId].index,
         chapters[chapterId].secretariat.secretary,
         chapters[chapterId].secretariat.members
       );
      return true;
  }

  /// Set new secretary
  function setNewSecretary(uint24[3] chapterId, address _secretary) returns (bool success) {
    if(!isExistingChapter(chapterId)) throw;
    // Set Secretary
    chapters[chapterId].secretariat.secretary = _secretary;
    return true;
  }

  /// Set chapter president
  /// @param uint24[3] chapterId
  /// @param ExecutiveCommittee executiveCommittee
  /// @return address executiveCommitteeAddr
  function setChapterPresident(address _president) returns (bool success) {
      chapters[chapterId].president = _president;
  }


  /// Get chapter by ID
  /// @param address _chapterId
  /// @return Chapter chapter
  function getChapterById(address _chapterId)
    public
    constant
    returns(Chapter chapter)
  {
    return chapters[_chapterId];
  }

  /// getChapterBodies
  /// @param uint24[3] chapterId
  /// return ...
  function getChapterBodies(uint24[3] chapterId)
    public
    constant
    returns(
      uint index,
      address forum,
      address executiveCommittee,
      address boardOfDirectors,
      address secretariat,
      address chapterPresident,
      address chapterSecretary
      )
  {
    if(!isExistingChapter(chapterId)) throw;
    return(
      chapters[chapterId].index,
      chapters[chapterId].forum,
      chapters[chapterId].executiveCommittee,
      chapters[chapterId].boardOfDirectors,
      chapters[chapterId].secretariat,
      chapters[chapterId].chapterPresident,
      chapters[chapterId].chapterSecretary
    );
  }

  /// getChapterCount
  /// return uint count
  function getChapterCount()
    public
    constant
    returns(uint count)
  {
    return  chapterIndex.length;
  }

  /// getChapterAtIndex
  /// @param uint index
  /// @return address chapterId
  function getChapterAtIndex(uint index)
    public
    constant
    returns(address chapterId)
  {
    return  chapterIndex[index];
  }






  /// Insert chapter body
    /// @param string bodyType {ExecutiveCommittee, Forum, BoardOfDirectors, Secretariat, President, Secretary}
    /// @param uint24[3] chapterId
    /// Todo maybe not possible
    /*function insertChapterBody(enum chapterBodyType, uint24[3] chapterId, Chapter chapterBody) public returns(uint index) {
      if(!isExistingChapter(chapterId)) throw;
      //
      chapters[chapterId][chapterBodyType] = chapterBody;
      // push() returns the new length
      chapters[chapterId].index     =  chapterIndex.push(chapterId) - 1;

      LogBody(
          chapterId,
          chapters[chapterId].index,
          chapters[chapterId].forum,
          chapters[chapterId].executiveCommittee,
          chapters[chapterId].boardOfDirectors,
          chapters[chapterId].secretariat,
          chapters[chapterId].chapterPresident,
          chapters[chapterId].chapterSecretary
          );

      return  chapterIndex.length-1;
    }*/

    /*
      function updateChapterBody(uint24[3] chapterId, bytes32 ChapterBodyType)
        public
        returns(bool success)
      {
        if(!isExistingChapter(chapterId)) throw;
        //
        chapters[chapterId][ChapterBodyType] = ChapterBodyType;
        LogUpdateUser(
          chapterId,
          chapters[chapterId].index,
          userEmail,
          chapters[chapterId].userAge);
        return true;
      }
    */
}