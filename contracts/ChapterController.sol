pragma solidity ^0.4.11;

import './Registry.sol';
import './ChapterStorage.sol';

/// @title Chapter Controller
/// @author 97Network
contract ChapterController is Registry {
  Registry registry;

  function ChapterController(address _registryAddress) {
    registryAddress = _registryAddress;
    registry = Registry(registryAddress);
  }
  /// @notice Create Global chapter
  /// @dev Called once. There is only one global chapter
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return bool
  function createChapterGlobal(address _president, address _secretary) returns (bool _success) {
     // if is BoardOfDirectors
     _success = ChapterStorage(registry.getContract('s:chapter')).createChapterGlobal(_president, _secretary);
     return _success;
  }

  /// @notice Create National chapter
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return ChapterNational
  function createChapterNational(address _president, address _secretary) returns (bool _success) {
     Registry registry = Registry(registryAddress);
     // if is BoardOfDirectors
     _success = ChapterStorage(registry.getContract('s:chapter')).createChapterNational(_president, _secretary);
     return _success;
  }

  /// @notice Create Local chapter
  /// @param _chapterNationalId The chapter National Id
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return ChapterLocal
  function createChapterLocal(uint24 _chapterNationalId, address _president, address _secretary) returns (bool _success) {
     // if is BoardOfDirectors
     _success = ChapterStorage(registry.getContract('s:chapter')).createChapterLocal(_chapterNationalId, _president, _secretary);
     return _success;
  }
}