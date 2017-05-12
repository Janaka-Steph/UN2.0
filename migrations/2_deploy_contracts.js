var Chapters = artifacts.require("./Chapters.sol");
var ChapterInterface = artifacts.require("./ChapterInterface.sol");
var ChapterController = artifacts.require("./ChapterController.sol");
var ChapterDatabase = artifacts.require("./ChapterDatabase.sol");
var ArbitrationCourt = artifacts.require("./ArbitrationCourt.sol");
var RightManagements = artifacts.require("./RightManagements.sol");

module.exports = function(deployer) {
  deployer.deploy(Chapters);
  deployer.deploy(ChapterInterface);
  deployer.deploy(ChapterController);
  deployer.deploy(ChapterDatabase);
  deployer.deploy(ArbitrationCourt);
  deployer.deploy(RightManagements);
};
