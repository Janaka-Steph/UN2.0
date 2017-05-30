pragma solidity ^0.4.11;

import './ChapterStorage.sol';

/// @title Chapter Global Storage
/// @author 97Network
contract ChapterGlobalStorage {

  /// @notice Create global chapter
  /// @dev Called once. There is only one global chapter
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return bool
  function createChapterGlobal(address _president, address _secretary) returns (bool _success) {
    chapterGlobal.president = _president;
    chapterGlobal.secretariat.secretary = _secretary;
    chapterGlobal.moderators['name2'] = 0x3;
    _success = true;
    return _success;
  }
}