let Autocracy = artifacts.require("Autocracy");
let Legislator = artifacts.require("Legislator");
let NormCorpus = artifacts.require("NormCorpus");
let GDAO = artifacts.require("GDAO");
let Valid = artifacts.require("Valid");

let ChapterController = artifacts.require("./ChapterController.sol");
let ChapterInterface = artifacts.require("./ChapterInterface.sol");
let ChapterStorage = artifacts.require("./ChapterStorage.sol");

module.exports = function (deployer) {
  deployer.deploy(NormCorpus)
    .then(() => console.log(`\n\nNormCorpus deployed at: ${NormCorpus.address}`))
    .then(() => deployer.deploy(GDAO, NormCorpus.address))
    .then(() => console.log(`GDAO deployed at: ${GDAO.address}`))
    .then(() => deployer.deploy(Autocracy))
    .then(() => console.log(`Autocracy deployed at: ${Autocracy.address}`))
    .then(() => deployer.deploy(Legislator, GDAO.address, Autocracy.address))
    .then(() => console.log(`Legislator deployed at: ${Legislator.address}`))
    .then(() => NormCorpus.at(NormCorpus.address).insert.sendTransaction(Legislator.address))
    .then(() => console.log(`Legislator ${Legislator.address} inserted into NormCorpus ${NormCorpus.address}`))
    .then(() => deployer.deploy(ChapterInterface))
    .then(() => deployer.deploy(ChapterStorage))
    .then(() => deployer.deploy(ChapterController, GDAO.address, ChapterStorage.address))
};

//.then(() => {
  //var normCorpusAdress = await GDAO.at(GDAO.address).getInstance();
  //deployer.deploy(ChapterController, GDAO.address)
//})