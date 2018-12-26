var Migrations = artifacts.require("./Migrations.sol");
var RedShift = artifacts.require("./redshift.sol");
module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(RedShift);
};
