// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LightBulb {
    // State variable to store the state of the bulb
    bool public isOn;

    // Event to log the state changes of the light bulb
    event LightStateChanged(bool isOn);

    // Constructor to initialize the bulb's state (off by default)
    constructor() {
        isOn = false;
    }

    // Function to turn the light on
    function turnOn() public {
        require(!isOn, "The light is already ON.");
        isOn = true;
        emit LightStateChanged(isOn);
    }

    // Function to turn the light off
    function turnOff() public {
        require(isOn, "The light is already OFF.");
        isOn = false;
        emit LightStateChanged(isOn);
    }

    // Function to toggle the light's state (ON/OFF)
    function toggle() public {
        isOn = !isOn;
        emit LightStateChanged(isOn);
    }

    // Function to check if the light is on
    function checkState() public view returns (bool) {
        return isOn;
    }
}
