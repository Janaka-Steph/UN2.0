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

	function testChapterNationalExists() {
		var beTrue = chapterstorage.isChapterNationalExists(1);
		Assert.isTrue(beTrue, "Should return true");
		var national = chapterstorage.createChapterNational(1, 2);
		Assert.isTrue(national, "Should return true");
		var beFalse = chapterstorage.isChapterNationalExists(3);
		Assert.isFalse(beFalse, "Should return false");
	}
/*
	function testChaptersCreation() {
		var global = chapterstorage.createChapterGlobal(1, 2);
		var national = chapterstorage.createChapterNational(1, 2);
		var local = chapterstorage.createChapterLocal(1, 1, 2);

		Assert.isTrue(global, "Should return true");
		Assert.isTrue(national, "Should return true");
		Assert.isTrue(local, "Should return true");
	}
*/
	function testCreateTwoGlobalChapters() {
		var global = chapterstorage.createChapterGlobal(1, 2);
		Assert.isTrue(global, "Should return true");
		var global2 = chapterstorage.createChapterGlobal(1, 2);
		Assert.isTrue(global2, "Should not work but I'm sure it will"); //TODO: Prevent multiple global chapters.
	}
}
