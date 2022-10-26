// SPDX-License-Identifier: LGPL-3.0-only

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract BatchTransfer {
    using SafeMath for uint256;
    event SafeSend(
        address indexed sender,
        address indexed receiver,
        uint256 value
    );
    event SafeReceived(address indexed sender, uint256 value);

    receive() external payable {
        emit SafeReceived(msg.sender, msg.value);
    }

    function batchTransferAverage(address[] calldata receivers) public payable {
        require(
            receivers.length <= 50 && receivers.length > 0,
            "Can not translate more than 50 once"
        );
        uint256 value2 = msg.value.div(receivers.length);
        require(value2 >= 0, "Transfer value should not be 0");
        for (uint256 i = 0; i < receivers.length; i++) {
            payable(receivers[i]).transfer(value2);
            emit SafeSend(msg.sender, receivers[i], value2);
        }
    }

    function batchTransfer(
        address[] calldata receivers,
        uint256[] calldata values
    ) public payable {
        require(
            receivers.length <= 50 &&
                receivers.length > 0 &&
                receivers.length == values.length,
            "The number of receivers must be greater than 0 and less than 50 and the same as the values number"
        );
        uint256 totalvalue = 0;
        for (uint256 i = 0; i < receivers.length; i++) {
            payable(receivers[i]).transfer(values[i]);
            emit SafeSend(msg.sender, receivers[i], values[i]);
            totalvalue = totalvalue.add(values[i]);
        }
        if (msg.value > totalvalue) {
            payable(msg.sender).transfer(msg.value - totalvalue);
        }
    }
}
