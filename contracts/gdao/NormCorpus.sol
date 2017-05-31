pragma solidity ^0.4.11;

import "./NormCorpusInterface.sol";
import "./GDAO.sol";
import "./Owned.sol";

contract NormCorpus is NormCorpusInterface, Owned {

    mapping(address => bool) public isNorm;
    uint public numberOfNorms;
    event InsertContract(address);
    event CallerNotValid(address);


    function NormCorpus(){
      owner = msg.sender;
    }

    modifier isCallerValidOrOwner {

        if (contains(msg.sender)) {
            _;
        }
        else if (owner == msg.sender) {
            _;
        }
        else CallerNotValid(msg.sender);
    }

    function insert(address _contract) isCallerValidOrOwner {
        isNorm[_contract] = true;
        InsertContract(_contract);
        numberOfNorms = numberOfNorms + 1;
    }

    function remove(address _contract) isCallerValidOrOwner {
        delete isNorm[_contract];
        numberOfNorms = numberOfNorms - 1;
    }

    function contains(address _contract) public constant returns(bool) {
        return isNorm[_contract];
    }
}
