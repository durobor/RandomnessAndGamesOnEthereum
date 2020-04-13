pragma solidity >=0.4.22;

import "./Owner.sol";

contract CoinFlipper is Owner {
    uint private seedIndex = 0;
    uint private profit = 2;
    
    function flip() public payable {
        require(1 ether >= msg.value, "Bet must be equal or less than 1 ether");
        require(2*msg.value <= address(this).balance, "Not enough funds to reward a winning bet");
        
        if(0 == uint(keccak256(abi.encodePacked(seedIndex))) % 2) {
            msg.sender.transfer(2*msg.value);
        }
        seedIndex++;
    }
    
    function receiveEther() external payable {}
    
    function withdraw(uint _withdrawAmount) public isOwner {
        msg.sender.transfer(_withdrawAmount);
    }
    
    function getSeedIndex() public view returns(uint) {
        return seedIndex;
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}
