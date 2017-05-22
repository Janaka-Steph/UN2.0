let ChapterStorageAbstraction = artifacts.require("./ChapterStorage.sol")
let expectThrow = require('../utils/expectThrow.js')

let ChapterStorage = null

before(async () => {
  ChapterStorage = await ChapterStorageAbstraction.deployed()
  // ChapterStorage.allEvents((error, log) => !error && console.log(log.args.index.valueOf()))
})

let itClean = (title, itCb) => contract(title, () => it(title, itCb))


describe('ChapterStorage', () => {
  describe('- National Chapters', () => {
    itClean("should create a national chapter", async () => {
      assert.isNotOk(await ChapterStorage.isChapterNationalExists(1), 'should not have national chapter 1')
      await ChapterStorage.createChapterNational.sendTransaction(0xbeef1, 0xbeef2)
      assert.isOk(await ChapterStorage.isChapterNationalExists(1), 'should have national chapter 1')
      await ChapterStorage.createChapterNational.sendTransaction(0xbeef1, 0xbeef2)
      assert.isOk(await ChapterStorage.isChapterNationalExists(2), 'should have national chapter 2')
    })

    itClean("should emit event of incremented index correctly", async () => {
      let indexEvent = ChapterStorage.LogIndex()
      // Call 1
      await ChapterStorage.createChapterNational.sendTransaction(0xbeef1, 0xbeef2)
      assert.equal(1, await indexEvent.get()[0].args.index.valueOf(), 'should emit 1')
      // Call 2
      await ChapterStorage.createChapterNational.sendTransaction(0xbeef1, 0xbeef2)
      assert.equal(2, await indexEvent.get()[0].args.index.valueOf(), 'should emit 2')
    })

    describe('- President', () => {
      itClean("should insert a new national president", async () => {
        // Create a national chapter
        await ChapterStorage.createChapterNational.sendTransaction(0xbeef1, 0xbeef2)
        // Set a new president
        await ChapterStorage.setChapterNationalPresident.sendTransaction(1, 0xbeef99)
        let actual = await ChapterStorage.getChapterNationalPresident.call(1)
        assert.equal(actual, 0xbeef99, 'should equal 0xbeef99')
      })

      itClean("should throw if the national chapter doesn't pre-exists when setting new president", async () => {
        await expectThrow(ChapterStorage.setChapterNationalPresident.sendTransaction(1, 0xbeef99))
      })
    })

    describe('- Secretary', () => {
      itClean("should insert a new national secretary", async () => {
        // Create a national chapter
        await ChapterStorage.createChapterNational.sendTransaction(0xbeef1, 0xbeef2)
        // Set a new secretary
        await ChapterStorage.setChapterNationalSecretary.sendTransaction(1, 0xbeef99)
        let actual = await ChapterStorage.getChapterNationalSecretary.call(1)
        assert.equal(actual, 0xbeef99, 'should equal 0xbeef99')
      })

      itClean("should throw if the national chapter doesn't pre-exists when setting new secretary", async () => {
        await expectThrow(ChapterStorage.setChapterNationalSecretary.sendTransaction(1, 0xbeef99))
      })
    })
  })

  describe('- Local Chapters', () => {
    itClean("should create a local chapter", async () => {
      assert.isNotOk(await ChapterStorage.isChapterLocalExists(1, 1), 'should not have local chapter 1')
      await ChapterStorage.createChapterLocal.sendTransaction(1, 0xbeef1, 0xbeef2)
      assert.isOk(await ChapterStorage.isChapterLocalExists(1, 1), 'should have local chapter 1')
      assert.isNotOk(await ChapterStorage.isChapterLocalExists(1, 2), 'should not have local chapter 2')
      await ChapterStorage.createChapterLocal.sendTransaction(1, 0xbeef1, 0xbeef2)
      assert.isOk(await ChapterStorage.isChapterLocalExists(1, 2), 'should have local chapter 2')
      assert.isNotOk(await ChapterStorage.isChapterLocalExists(1, 3), 'should not have local chapter 3')
      assert.isNotOk(await ChapterStorage.isChapterLocalExists(2, 2), 'should not have local chapter 2 in chapter national 2')
    })

    itClean("should emit event of incremented index correctly", async () => {
      let indexEvent = ChapterStorage.LogIndex()
      // Call 1
      await ChapterStorage.createChapterLocal.sendTransaction(200, 0xbeef1, 0xbeef2)
      assert.isOk(await ChapterStorage.isChapterLocalExists(200, 1), 'should have local chapter 1')
      assert.equal(1, await indexEvent.get()[0].args.index.valueOf(), 'should emit 1')
      // Call 2
      await ChapterStorage.createChapterLocal.sendTransaction(200, 0xbeef1, 0xbeef2)
      assert.isOk(await ChapterStorage.isChapterLocalExists(200, 2), 'should have local chapter 2')
      assert.equal(2, await indexEvent.get()[0].args.index.valueOf(), 'should emit 2')
      // No call 3
      assert.isNotOk(await ChapterStorage.isChapterLocalExists(200, 3), 'should not have local chapter 3')
    })

    describe('- President', () => {
      itClean("should insert a new local president", async () => {
        // Create a local chapter on chapter national 22
        await ChapterStorage.createChapterLocal.sendTransaction(22, 0xbeef1, 0xbeef2)
        // Set a new president
        await ChapterStorage.setChapterLocalPresident.sendTransaction(22, 1, 0xbeef99)
        let actual = await ChapterStorage.getChapterLocalPresident.call(22, 1)
        assert.equal(actual, 0xbeef99, 'should equal 0xbeef99')
      })

      itClean("should throw if the local chapter doesn't pre-exists when setting new president", async () => {
        await expectThrow(ChapterStorage.setChapterLocalPresident.sendTransaction(22, 1, 0xbeef99))
      })
    })

    describe('- Secretary', () => {
      itClean("should insert a new local secretary", async () => {
        // Create a local chapter on chapter national 22
        await ChapterStorage.createChapterLocal.sendTransaction(22, 0xbeef1, 0xbeef2)
        // Set a new secretary
        await ChapterStorage.setChapterLocalSecretary.sendTransaction(22, 1, 0xbeef99)
        let actual = await ChapterStorage.getChapterLocalSecretary.call(22, 1)
        assert.equal(actual, 0xbeef99, 'should equal 0xbeef99')
      })

      itClean("should throw if the local chapter doesn't pre-exists when setting new secretary", async () => {
        await expectThrow(ChapterStorage.setChapterLocalSecretary.sendTransaction(22, 1, 0xbeef99))
      })
    })
  })
})