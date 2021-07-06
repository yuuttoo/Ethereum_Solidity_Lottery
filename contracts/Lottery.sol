//pragma solidity >=0.4.21 <0.7.0;
// pragma solidity ^0.4.25
pragma solidity ^0.4.17; 

contract Lottery {
    address public manager;
    address[] public players; //玩家的陣列  
    
    constructor() public {
        manager = msg.sender;
    }
    // function Lottery() public { 
    //         manager = msg.sender;
    //     }    


    function enter() public payable{//進入遊戲要先付錢
        require(msg.value > .01 ether);//須通過這裡驗證先付出以太幣 後面的function才會繼續跑
    
        players.push(msg.sender);//把地址放進去array
        
    }
    
    function random() private view  returns (uint) {
    //return uint(keccak256(block.difficulty, now, players)); //會隨機給出一個龐大數字
    //return abi.encodePacked(uint(keccak256(block.difficulty, now, players)));
    return uint(keccak256(abi.encodePacked(block.difficulty, now, players)));
    }
    function pickWinner() public restricted {
        //require(msg.sender == manager); //只有manager才能觸發這個函式
        
        uint index = random() % players.length; //拿上面隨機數來選palyer 裡面的陣列順序
        players[index].transfer(address(this).balance ); //this.address(contract).balance//付錢 該玩家得到所有餘額
        players = new address[](0); //清空原本玩家的陣列 進行下一輪
    }
    //"address(contract).balance
    
    modifier restricted() {
        require(msg.sender == manager);
        _; //代表後續的其他函式
    }
    
    function getPlayers() public view returns (address[]) {
        return players;
    }
    
    
    
    
}