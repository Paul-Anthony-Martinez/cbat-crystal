# CBAT-Crystal
A simple Crystal program to display current battery information, made with the idea of having little to no dependencies and being easy to understand and modify.

`<BAT0>  [████░░░░░░░░░░░░░░░░] [21%] [Discharging]`

# How to build cbat yourself
1. Clone this repository and check the source code.
2. Modify to your liking and save it.
3. Make sure you have crystall installed in your system:
   ```crystal --version```
4. To build it, run the following command:
   ```crystal build cbat.cr -o cbat```

# Dependencies
At the current version, none.

# Where is the data gathered from?
All the information is gathered from the ```/sys/class/power_supply/BAT*/capacity``` and ```/sys/class/power_supply/BAT*/status``` files. If your system saves the battery information in another directory, you might want to change the variable ```supply_dir``` to the right directory for your system.
