pragma solidity ^0.4.11;

import './gdao/GDAO.sol';
import './gdao/NormCorpusInterface.sol';
import './ChapterStorage.sol';

/// @title Chapter Controller
/// @author 97Network
contract ChapterController {
  GDAO gdao;
  NormCorpusInterface normCorpus;
  ChapterStorage chapterStorage;

  function ChapterController(GDAO _gdao, ChapterStorage _chapterStorage) {
    chapterStorage = _chapterStorage;
    normCorpus = _gdao.getInstance();
    normCorpus.insert(_chapterStorage);
  }
  /// @notice Create Global chapter
  /// @dev Called once. There is only one global chapter
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return bool
  function createChapterGlobal(address _president, address _secretary) returns (bool _success) {
     // if is BoardOfDirectors
     _success = chapterStorage.createChapterGlobal(_president, _secretary);
     return _success;
  }

  /// @notice Create National chapter
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return ChapterNational
  function createChapterNational(address _president, address _secretary) returns (bool _success) {
     //Registry registry = Registry(registryAddress);
     // if is BoardOfDirectors
     //_success = ChapterStorage(registry.getContract('s:chapter')).createChapterNational(_president, _secretary);
     return _success;
  }

  /// @notice Create Local chapter
  /// @param _chapterNationalId The chapter National Id
  /// @param _president The president
  /// @param _secretary The secretary
  /// @return ChapterLocal
  function createChapterLocal(uint24 _chapterNationalId, address _president, address _secretary) returns (bool _success) {
     // if is BoardOfDirectors
     //_success = ChapterStorage(registry.getContract('s:chapter')).createChapterLocal(_chapterNationalId, _president, _secretary);
     return _success;
  }
}