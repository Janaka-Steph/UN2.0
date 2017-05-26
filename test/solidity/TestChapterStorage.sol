pragma solidity ^0.4.11;

// The 2 imports below are required by Truffle
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";

/* Import necessary contracts below : */
import "../../contracts/ChapterStorage.sol";

contract TestChapterStorage {

/* Init Global Variables below : */
// int global = 0;
	ChapterStorage chapterstorage;

/*	Mocha function/tools below : */
//	function beforeAll(){}
//	function afterAll(){}
//	function afterEach(){}

	function beforeEach(){
		chapterstorage = ChapterStorage(DeployedAddresses.ChapterStorage());
	}


	/* Testing functions below */
	function testChaptersCreation() {
		var global = chapterstorage.createChapterGlobal(1, 2);
		var national = chapterstorage.createChapterNational(1, 2);
		var local = chapterstorage.createChapterLocal(1, 1, 2);

		Assert.isTrue(global, "Should return true");
		Assert.isTrue(national, "Should return true");
		Assert.isTrue(local, "Should return true");

	}
}
