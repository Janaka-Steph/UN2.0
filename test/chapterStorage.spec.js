let ChapterStorageAbstraction = artifacts.require("./ChapterStorage.sol")
let ChapterStorage = null

before(async () => {
  ChapterStorage = await ChapterStorageAbstraction.deployed()
  // ChapterStorage.allEvents((error, log) => !error && console.log(log.args.index.valueOf()))
})

let itClean = (title, itCb) => contract(title, () => it(title, itCb))


describe('ChapterStorage', () => {
  describe('- National Chapters', () => {
    itClean("should create a national chapter", async () => {
      await ChapterStorage.createChapterNational.sendTransaction(1, 0xbeef1, 0xbeef2)
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
      assert.isNotOk(await ChapterStorage.isChapterLocalExists(2, 2), 'should not have local chapter 2 in chap nat 2')
    })

    itClean("should increment index correctly", async () => {
      let events, indexEvent = ChapterStorage.LogIndex()

      await ChapterStorage.createChapterLocal.sendTransaction(200, 0xbeef1, 0xbeef2)
      assert.isOk(await ChapterStorage.isChapterLocalExists(200, 1), 'should have local chapter 1')
      events = await indexEvent.get()
      assert.equal(1, events[0].args.index.valueOf())

      await ChapterStorage.createChapterLocal.sendTransaction(200, 0xbeef1, 0xbeef2)
      assert.isOk(await ChapterStorage.isChapterLocalExists(200, 2), 'should have local chapter 2')
      events = await indexEvent.get()
      assert.equal(2, events[0].args.index.valueOf())

      await ChapterStorage.createChapterLocal.sendTransaction(200, 0xbeef1, 0xbeef2)
      assert.isOk(await ChapterStorage.isChapterLocalExists(200, 3), 'should have local chapter 3')
      events = await indexEvent.get()
      assert.equal(3, events[0].args.index.valueOf())

      await ChapterStorage.createChapterLocal.sendTransaction(200, 0xbeef1, 0xbeef2)
      assert.isOk(await ChapterStorage.isChapterLocalExists(200, 4), 'should have local chapter 4')
      events = await indexEvent.get()
      assert.equal(4, events[0].args.index.valueOf())

      assert.isNotOk(await ChapterStorage.isChapterLocalExists(200, 5), 'should not have local chapter 5')
    })

    itClean("should insert a new president", async () => {
      await ChapterStorage.createChapterLocal.sendTransaction(1, 0xbeef1, 0xbeef2)
      assert.equal(await ChapterStorage.getChapterLocalPresident.call(1, 1), 0xbeef1)
    })

    itClean("should insert a new secretary", async () => {
      await ChapterStorage.createChapterLocal.sendTransaction(18, 0xbeef1, 0xbeef2)
      assert.equal(await ChapterStorage.getChapterLocalSecretary.call(18, 1), 0xbeef2)
    })
  })
})