// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BuggyContract {
    using SafeMath for uint;

    uint private count = 0;
    string messages;
    bool public isPaused = false;
    address owner;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    // Bug 1
    // fixed
    function setOwner() public {
        owner = msg.sender;
    }

    // Bug 2
    // fixed
    function increment(uint amount) private {
        count += amount;
    }

    // Bug 3
    // fixed
    function getCount() public view returns (uint) {
        return count;
    }

    // Bug 4
    //fixed
    function divideCount(uint divisor) public view returns (uint) {
        require(divisor != 0, "divisor cannot be zero");
        require(divisor <= count, "divisor cannot be bigger than count");
        count = count / divisor;
        return count;
    }

    // Bug 5
    // Hint: make sure that message is only stored temporarily
    // fixed
    function setMessage(string memory newMessage) public {
        messages = newMessage;
    }

    // Bug 6
    // Hint: two things to do here.
    // Think about how to make the loop more efficient
    // and read the compiler
    // loop fixed
    function sumNumbers(uint n) public pure returns (uint) {
        uint sum = 0;
        for (uint i = 0; i <= n; i++) {
            sum += i;
        }
        return sum;
    }

    // Bug 7
    // Hint: Think about math operation overflow
    // fixed
    function setCountWithMultiplication(uint x, uint y) public {
        require(x == 0 || y == 0 || (x*y) / x == y, "multiplication overflow");
        count = x * y;
    }

    // Bug 8
    // fixed
    function resetCount() public onlyOwner {
        count = 0;
    }

    // Bug 9
    // fixed
    function togglePause() public onlyOwner {
        isPaused = !isPaused;
    }
}
