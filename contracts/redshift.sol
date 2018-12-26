pragma solidity ^0.4.23;

contract RedShift {
    struct RiddleItem {
        bytes32 ansHash;
        uint256 bounty;
        address proposer;
        bool cracked;
        address cracker;
    }

    // Note: should use "address payable" on newer version solc
    address public owner;
    uint256 constant CRACK_FEE = 1 trx;
    mapping(bytes32 => RiddleItem) public riddles;
    uint256 public serviceCharge;

    event riddleCreated(string hash);
    event riddleCracked(string hash, address cracker);
    event riddleCrackFailed(string hash, string ans);

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function riddle(string memory riddleHash, string memory ansHash) public payable {
        require(msg.value >= CRACK_FEE);
        bytes32 id = stringToBytes32(riddleHash);
        require(riddles[id].bounty == 0);
        bytes32 ansHashBytes = stringToBytes32(ansHash);
        riddles[id] = RiddleItem(ansHashBytes, msg.value, msg.sender, false, address(0));
        emit riddleCreated(riddleHash);
    }

    function crack(string memory riddleHash, string memory ans) public payable {
        bytes32 id = stringToBytes32(riddleHash);
        require(riddles[id].bounty != 0);
        require(!riddles[id].cracked);
        require(msg.value >= CRACK_FEE);

        bytes32 ansHash = sha256(abi.encodePacked(ans));
        if (ansHash == riddles[id].ansHash) {
            riddles[id].cracked = true;
            riddles[id].cracker = msg.sender;
            msg.sender.transfer(riddles[id].bounty);
            emit riddleCracked(riddleHash, msg.sender);
        } else {
            emit riddleCrackFailed(riddleHash, ans);
        }

        serviceCharge += msg.value;
    }

    function isRiddleCracked(string memory riddleHash) public view returns (bool, address) {
        bytes32 id = stringToBytes32(riddleHash);
        return (riddles[id].cracked, riddles[id].cracker);
    }

    function withdrawServiceCharge() public onlyOwner {
        owner.transfer(serviceCharge);
    }

    function uintToAscii(uint number) private pure returns (byte) {
        if (number < 10) {
            return byte(uint8(48 + number));
        } else if (number < 16) {
            return byte(uint8(87 + number));
        } else {
            revert();
        }
    }

    function asciiToUint(byte char) private pure returns (uint) {
        uint8 asciiNum = uint8(char);
        if (asciiNum > 47 && asciiNum < 58) {
            return asciiNum - 48;
        } else if (asciiNum > 96 && asciiNum < 103) {
            return asciiNum - 87;
        } else {
            revert();
        }
    }

    function bytes32ToString (bytes32 data) private pure returns (string memory) {
        bytes memory bytesString = new bytes(64);
        for (uint j=0; j < 32; j++) {
            uint char = uint(data) * 2 ** (8 * j);
            bytesString[j*2+0] = uintToAscii(char / 16);
            bytesString[j*2+1] = uintToAscii(char % 16);
        }
        return string(bytesString);
    }

    function stringToBytes32(string memory str) private pure returns (bytes32) {
        bytes memory bString = bytes(str);
        uint uintString;
        if (bString.length != 64) {
            revert();
        }
        for (uint i = 0; i < 64; i++) {
            uintString = uintString*16 + asciiToUint(bString[i]);
        }
        return bytes32(uintString);
    }
}

