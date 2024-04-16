# CBAT-Crystal
A simple Crystal program to display current battery information, made with the idea of having little to no dependencies and being easy to understand and modify. The battery name will be displayed alongside a simple ascii bar, charge percentage and current state, like so:

`<BAT0>  [████░░░░░░░░░░░░░░░░] [21%] [Discharging]`

# How to build cbat yourself
1. Clone this repository and check the source code in the 'src' and 'src/res' directories.
2. Modify to your liking and save it.
3. Make sure you have crystal installed in your system:
   ```crystal --version```
4. To build it, run the following command:
   ```shards build```
5. Go to the 'bin' directory created in the project and run 'cbat'.
Note: Remember to give execution permission to cbat: chmod +x cbat.

# Dependencies
At the current version, none.

# Where is the data gathered from?
All the information is gathered from the ```/sys/class/power_supply/BAT*/capacity``` and ```/sys/class/power_supply/BAT*/status``` files. If your system saves the battery information in another directory, you might want to change the class attribute ```@supply_dir``` to the right directory for your system.

# How to run your cbat.cr file
1. Save the file with: ```.cr```extension or place a shebang for crystal in the first line of the file such as ```#!/bin/crystal```.
2. Run the file with: ```crystal cbat.cr```
3. When finished editing, build the program (follow the build steps).
4. Give the program execution permission by running ```chmod +x cbat```.
5. You can edit your ```~/.bashrc``` file and place an alias to run the script wherever it's placed like ```alias cbat=/home/<username>/Downloads/./cbat```
6. Source the ```.bashrc```file: ```source ~/.bashrc```.
7. Try running: `cbat`.
