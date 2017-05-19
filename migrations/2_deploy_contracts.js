let ChapterController = artifacts.require("./ChapterController.sol");
let ChapterInterface = artifacts.require("./ChapterInterface.sol");
let ChapterStorage = artifacts.require("./ChapterStorage.sol");
let Registry = artifacts.require("./Registry.sol");

module.exports = function(deployer) {
  deployer.deploy([
    ChapterController,
    ChapterInterface,
    ChapterStorage
  ])
    .then(() => deployer.deploy(Registry)
      .then(() => {
        Registry.at(Registry.address).registerContract('c:chapter', ChapterController.address);
        Registry.at(Registry.address).registerContract('i:chapter', ChapterInterface.address);
        Registry.at(Registry.address).registerContract('s:chapter', ChapterStorage.address);
      })
    )
};
