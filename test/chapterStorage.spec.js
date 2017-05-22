let ChapterStorageAbstraction = artifacts.require("./ChapterStorage.sol")
let ChapterStorage = null

before(async () => {
  ChapterStorage = await ChapterStorageAbstraction.deployed()
})

let itClean = (title, itCb) => contract(title, () => it(title, itCb))


describe('ChapterStorage', () => {
  describe('- Local Chapters', () => {
    itClean("should create a local chapter at the right index", async () => {
      assert.isNotOk(await ChapterStorage.isChapterLocalExists(1, 1), 'should not have local chapter 1')
      await ChapterStorage.createChapterLocal.sendTransaction(1, 0xbeef1, 0xbeef2)
      assert.isOk(await ChapterStorage.isChapterLocalExists(1, 1), 'should have local chapter 1')
      assert.isNotOk(await ChapterStorage.isChapterLocalExists(1, 2), 'should not have local chapter 2')
      await ChapterStorage.createChapterLocal.sendTransaction(1, 0xbeef1, 0xbeef2)
      assert.isOk(await ChapterStorage.isChapterLocalExists(1, 2), 'should have local chapter 2')
      assert.isNotOk(await ChapterStorage.isChapterLocalExists(1, 3), 'should not have local chapter 3')
      assert.isNotOk(await ChapterStorage.isChapterLocalExists(2, 2), 'should not have local chapter 2 in chap nat 2')
    })

    itClean("should insert a new president", async () => {
      await ChapterStorage.createChapterLocal.sendTransaction(1, 0xbeef1, 0xbeef2)
      assert.equal(await ChapterStorage.getChapterLocalPresident.call(1, 1), 0xbeef1)
    })

    itClean("should insert a new secretray", async () => {
      await ChapterStorage.createChapterLocal.sendTransaction(18, 0xbeef1, 0xbeef2)
      assert.equal(await ChapterStorage.getChapterLocalSecretary.call(18, 1), 0xbeef2)
    })
  })
})