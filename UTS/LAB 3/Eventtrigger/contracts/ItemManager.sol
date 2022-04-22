pragma solidity ^0.6.0;

import "./Ownable.sol";
import "./item.sol";

contract ItemManager is Ownable{

    struct S_Item {
        ItemManager.SupplyChainSteps _step;
        string _identifier;
        uint _priceInWei;
    }
    mapping(uint => S_Item) public items;
    uint index;

    enum SupplyChainSteps{Created, Paid, Delivered}

    event SupplyChainSteps(uint _itemIndex, uint _step, address _address);



    function createItem(string memory _identifier, uint _priceInWei) public onlyOwner{
        Item item = new Item(this, _priceInWei, index);
        items[index]._item = item;
        items[index]._priceInWei = _priceInWei;
        items[index]._step = SupplyChainSteps.Created;
        items[index]._identifier = _identifier;
        emit SupplyChainSteps(index, uint(items[index]._step), address(item));
        index++;
    }

    function triggerPayment(uin _index) public payable{
        Item item = items[_index]._item;
        require(address(item) == msg.sender, "Only items are allowed to update themselves");
        require(item.priceInWei() == msg. value, "Not fully paid yet");
        require(items[_index]._priceInWei <= msg.value, "Not Fully Paid");
        require(items[_index]._step == SupplyChainSteps.Created, "Item is further in the supply chain");
        items[_index]._step = SupplyChainSteps.Paid;
        emit SupplyChainSteps(_index, uint(items[_index]._step));
    }

    function triggerDelivery(uint _index) public onlyOwner{
        
        require(items[_index]._step == SupplyChainSteps.Paid, "Item is further in the supply chain");
        items[_index]._step == SupplyChainSteps.Delivered;
        emit SupplyChainSteps(_index, uint(items[_index]._step), address(items[_index].item));
    }
}