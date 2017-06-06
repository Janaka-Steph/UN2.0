pragma solidity ^0.4.11;

// The 2 imports below are required by Truffle
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";

/* Import necessary contracts below : */
import "../../contracts/ChapterStorage.sol";

contract TestChapterStorageNumbering {

	/* Init Global Variables below : */
	ChapterStorage chapterstorage;

	/*	Mocha function/tools below : */
	//	function beforeAll(){}
	//	function afterAll(){}
	//	function afterEach(){}

	function beforeEach(){
	chapterstorage = ChapterStorage(DeployedAddresses.ChapterStorage());
	}


	/* Testing functions below */



	function testCreateSomeChapters() {
		// First we create one of each.
		var global = chapterstorage.createChapterGlobal(1, 2);
		var national = chapterstorage.createChapterNational(1, 2);
		var local = chapterstorage.createChapterLocal(1, 1, 2);

		Assert.isTrue(global, "Should return true");
		Assert.isTrue(national, "Should return true");
		Assert.isTrue(local, "Should return true");
	}

	function testChapterNationalNumbers() {
		// Then we check we do have one an only one national.
		var existsA = chapterstorage.isChapterNationalExists(1);
		var existsB = chapterstorage.isChapterNationalExists(2);
			
		Assert.isTrue(existsA, "Should return true");
		Assert.isFalse(existsB, "Should return false");
		
		// Then we make a second one and checked if it was properly numbered.
		chapterstorage.createChapterNational(1, 2);
		Assert.isTrue(chapterstorage.isChapterNationalExists(2), "Should return true");
	}

	function testChapterLocalNumbers() {
		// Then we check we do have one an only one local.
		var existsA = chapterstorage.isChapterLocalExists(1, 1);
		var existsB = chapterstorage.isChapterLocalExists(1, 2);
			
		Assert.isTrue(existsA, "Should return true");
		Assert.isFalse(existsB, "Should return false");
		
		// Then we make a second one and checked if it was properly numbered.
		chapterstorage.createChapterLocal(1, 1, 2);
		Assert.isTrue(chapterstorage.isChapterLocalExists(1, 2), "Should return true");

		// Test some local chapters in second national chapter.
		Assert.isFalse(chapterstorage.isChapterLocalExists(2, 1), "Should return false");
		

		/*
		** Test below shows an error : We create a local chapter in national chapter 2,
		** This is the first local chapter we created in this national chapter.
		** Its number is not 1, it is number 3.
		** This is caused by the 2 local chapters we created in national chapter 1.
		** TODO : Make the local-numbering variable separate for each national chapters.
		*/
		chapterstorage.createChapterLocal(2, 1, 2);
		Assert.isTrue(chapterstorage.isChapterLocalExists(2, 3), "Should return true");
	}
}
