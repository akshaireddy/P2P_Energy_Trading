// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EnergyTrading {
    // Structure to represent an energy trade
    struct Trade {
        address seller;
        address buyer;
        uint256 energyAmount; // in kWh (kilowatt-hours)
        uint256 pricePerUnit; // in wei (smallest unit of Ether)
        bool isCompleted;
    }

    Trade[] public trades; // List of all energy trades

    // Create a new energy trade
    function createTrade(address _buyer, uint256 _energyAmount, uint256 _pricePerUnit) external {
        require(_buyer != address(0), "Invalid buyer address");
        require(_energyAmount > 0, "Invalid energy amount");
        require(_pricePerUnit > 0, "Invalid price per unit");

        trades.push(Trade({
            seller: msg.sender,
            buyer: _buyer,
            energyAmount: _energyAmount,
            pricePerUnit: _pricePerUnit,
            isCompleted: false
        }));
    }

    // Execute a trade, transferring energy and funds
    function executeTrade(uint256 _tradeIndex) external payable {
        require(_tradeIndex < trades.length, "Invalid trade index");
        Trade storage trade = trades[_tradeIndex];
        require(!trade.isCompleted, "Trade already completed");
        require(msg.sender == trade.buyer, "Only buyer can execute the trade");
        require(msg.value == trade.energyAmount * trade.pricePerUnit, "Incorrect payment amount");

        trade.isCompleted = true;

        // Transfer energy and funds
        payable(trade.seller).transfer(msg.value);
    }
}
