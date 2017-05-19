let ChapterController = artifacts.require("./ChapterController.sol");
let ChapterInterface = artifacts.require("./ChapterInterface.sol");
let ChapterStorage = artifacts.require("./ChapterStorage.sol");
let Registry = artifacts.require("./Registry.sol");

module.exports = function(deployer) {
  deployer.deploy([
    Registry,
    ChapterController,
    ChapterInterface,
    ChapterStorage
  ])
    .then(() => {
      Registry.at(Registry.address).registerContract('c:chapter', ChapterController.address);
      console.log(`ChapterController registered`);
      Registry.at(Registry.address).registerContract('i:chapter', ChapterInterface.address);
      console.log(`ChapterInterface registered`);
      Registry.at(Registry.address).registerContract('s:chapter', ChapterStorage.address);
      console.log(`ChapterStorage registered`);
    })
};
