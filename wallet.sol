pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


contract Wallet {
    bool  boun = true;
    uint16  flag1 = 1;
    uint16  flag2 = 160;
  
    constructor() public {
      
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }
  
    modifier checkOwnerAndAccept {

        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
		_;
	}

    // транзакция с комиссией, которая берется с суммы перевода
    function sendTransactionWithFee(address dest, uint128 value) public pure checkOwnerAndAccept {
                
        dest.transfer(value);
    }
    // транзакция с комиссией, которая берется с основного счёта
    function sendTransactionWithoutFee(address dest, uint128 value) public view checkOwnerAndAccept {
                
        dest.transfer(value, boun, flag1);
    }
    // транзакция всей суммы и уничтожение смартконтракта
     function sendTransactionWithAllMoney(address dest, uint128 value) public view checkOwnerAndAccept {
                
        dest.transfer(value, boun, flag2);
    }
   
}