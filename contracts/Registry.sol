pragma solidity ^0.4.11;

/// @title Registry
/// @author 97Network
contract Registry {

  mapping (bytes32 => address) contracts;

  function registerContract(bytes32 _name, address _contract) returns (bool _success) {
    contracts[_name] = _contract;
    _success = true;
    return _success;
  }

  function getContract(bytes32 _name) public constant returns (address _contract) {
    _contract = contracts[_name];
    return _contract;
  }
}