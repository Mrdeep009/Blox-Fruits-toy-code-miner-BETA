# Blox Fruits Mining Automation

## Description
This project is a Lua script designed to automate the mining process in the Blox Fruits game on Roblox. It utilizes various services provided by Roblox to enhance the mining experience, including performance monitoring and a user-friendly graphical interface.

## Features
- **Automated Code Generation**: Generates random codes for mining.
- **Performance Monitoring**: Tracks FPS and other performance metrics.
- **User Interface**: Displays real-time mining statistics and allows toggling of adaptive mode.
- **Adaptive Mode**: Automatically adjusts mining speed based on performance metrics.

## Installation
1. Clone the repository or download the files.
2. Open the scripts in Roblox Studio.
## OR
execute this ''' loadstring(game:HttpGet("https://raw.githubusercontent.com/Mrdeep009/blackboxai-1744533077607/refs/heads/main/main.lu)"))() '''

## Usage
- Press `X` to start mining.
- Press `Z` to stop mining.
- Use the "Toggle Adaptive Mode" button in the UI to enable or disable adaptive speed adjustments.


## License
This project is licensed under the MIT License. See the LICENSE file for details.

1.  **Purpose:** This script is designed for the Roblox game **Blox Fruits**. Its goal is to automatically and rapidly attempt to redeem promotional codes by generating random strings and sending them to the server. The term "mining" is used metaphorically for this brute-force code redemption process.

2.  **Core Logic:**
    * **Initialization:** It accesses necessary Roblox services (like `ReplicatedStorage`, `Players`, `RunService`) and locates a specific Remote Function (`RedeemRemote`) used for code redemption.
    * **Global State:** It uses global variables (`_G`) to manage settings and status:
        * `_G.CodeMining`: A flag to turn the mining process on or off.
        * `_G.MiningSpeed`: Determines how many codes are generated and attempted per second (initially set very high: 10,000).
        * `_G.AdaptiveMode`: Enables/disables a feature that adjusts the mining speed based on game performance (FPS).
        * `_G.MiningStatus`: A table tracking things like FPS, current speed, codes generated/executed, etc.
    * **Code Generation (`generateCode`):** Creates random 12-character alphanumeric strings (e.g., `A7XF9PQL3R8Z`).
    * **Redemption Attempt:** In the `executeMining` function, it loops `_G.MiningSpeed` times per second. In each iteration, it:
        * Generates a code using `generateCode`.
        * Calls the `RedeemRemote:InvokeServer()` function, sending the generated code to the Blox Fruits server to try and redeem it.
        * Uses `pcall` to safely handle errors if the redemption fails or the remote doesn't exist.
    * **Adaptive Speed (`adaptiveSpeedControl`):** If enabled, this function monitors the client's Frames Per Second (FPS). If the FPS drops too low (below 25), it reduces the `_G.MiningSpeed`. If the FPS is high (50+), it slightly increases the speed, trying to balance performance and redemption rate.
    * **Warm-Up (`warmUpMining`):** When starting, it doesn't immediately jump to the full `_G.MiningSpeed`. Instead, it gradually ramps up the speed over 5 seconds.
    * **Anti-AFK:** It includes a function to simulate a mouse click if the player becomes idle, preventing the game from disconnecting them for inactivity.
    * **User Control:**
        * Pressing **'X'** starts the mining process (calls `warmUpMining` then `executeMining`).
        * Pressing **'Z'** stops the mining process (sets `_G.CodeMining` to `false`).

**In Summary:**

This Lua script is an automation tool for Blox Fruits that tries to guess and redeem game codes at a very high speed. It includes features to prevent AFK disconnection and adapt its speed based on the game's performance.

**Important Considerations:**


* **Effectiveness:** Generating random 12-character codes has an extremely low probability of matching a valid, unused code. It's highly unlikely to yield significant results.
* **Performance/Server Strain:** Attempting thousands of server requests per second can severely impact your game's performance and put unnecessary load on the Blox Fruits servers, potentially triggering anti-cheat measures.
