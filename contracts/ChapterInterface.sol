pragma solidity ^0.4.11;

import './Registry.sol';
import './ChapterController.sol';

/// @title Chapter Interface
/// @author 97Network
contract ChapterInterface is Registry {
  Registry registry;

  function ChapterInterface(address _registryAddress) {
    registryAddress = _registryAddress;
    registry = Registry(registryAddress);
  }

  /// @notice Create global chapter
  /// @dev Called once. There is only one global chapter
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return bool
  function createChapterGlobal(address _president, address _secretary) returns (bool _success) {
    _success = ChapterController(registry.getContract('c:chapter')).createChapterGlobal(_president, _secretary);
    return _success;
  }

  /// @notice Create National chapter
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return ChapterNational
  function createChapterNational(address _president, address _secretary) returns (bool _success) {
    _success = ChapterController(registry.getContract('c:chapter')).createChapterNational(_president, _secretary);
    return _success;
  }

  /// @notice Create Local chapter
  /// @param _chapterNationalId The chapter National Id
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return ChapterLocal
  function createChapterLocal(uint24 _chapterNationalId, address _president, address _secretary) returns (bool _success) {
    _success = ChapterController(registry.getContract('c:chapter')).createChapterLocal(_chapterNationalId, _president, _secretary);
    return _success;
  }


  //
  // Art 56 - 1. Each chapter's board of directors is composed of the chapter president,
  // the chapter secretary and the moderators who the chapter president will consider necessary
  // function getBoardOfDirectorsByChapterId(uint24[3] _chapterId) returns (address[] _boardOfDirectors) {}
}