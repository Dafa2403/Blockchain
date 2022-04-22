var ItemManager = artifacts.reqiore("./ItemManager.sol");

module.exports = function(deployer){
  deployer.deploy(ItemManager);
}