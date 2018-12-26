var Test = artifacts.require("./redshift.sol");
contract('RedShift', function(accounts) {
	it("call method riddle", function() {
	    Test.deployed().then(function(instance) {
		  return instance.call('riddle', 'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad', 'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad');
		}).then(function(result) {
          tronWeb.trx.getBalance(accounts[0]).then(result => { console.log(tronWeb.fromSun(result)); })
	    });
	});
	it("call method crack", function() {
	    Test.deployed().then(function(instance) {
		  return instance.call('crack', 'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad', 'abc');
		}).then(function(result) {
          console.log(result);
	    });
	});
});



