// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Car {
    // State variables to track the state of the car
    bool public isEngineOn;
    bool public isCarRunning;
    address public owner;

    // Event to log state changes of the car
    event EngineStateChanged(bool isEngineOn);
    event CarStateChanged(bool isCarRunning);

    // Modifier to ensure only the owner can control the car
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can control the car.");
        _;
    }

    // Constructor to initialize the car with the owner and initial state (engine off and car stopped)
    constructor() {
        owner = msg.sender;
        isEngineOn = false;
        isCarRunning = false;
    }

    // Function to start the car engine
    function startEngine() public onlyOwner {
        require(!isEngineOn, "Engine is already ON.");
        isEngineOn = true;
        emit EngineStateChanged(isEngineOn);
    }

    // Function to stop the car engine
    function stopEngine() public onlyOwner {
        require(isEngineOn, "Engine is already OFF.");
        isEngineOn = false;
        emit EngineStateChanged(isEngineOn);
    }

    // Function to start the car (engine must be on)
    function startCar() public onlyOwner
