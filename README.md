# CBAT-Crystal
A simple Crystal program to display current battery information, made with the idea of having little to no dependencies and being easy to understand and modify. The battery name will be displayed alongside a simple ascii bar, charge percentage and current state, like so:

`<BAT0>  [████░░░░░░░░░░░░░░░░] [21%] [Discharging]`<br>
`BAT0|▮▮▯▯▯▯▯▯▯▯▯▯▯▯▯|10%|Discharging`

# How to build cbat yourself 
You can compile the `cbat` either through `shards` or with the `compile` script included in the project. 
Shards is the Crystal way of building while `compile` is a simple shell script to build `cbat` as minimal as posible.

1. Clone this repository and check the source code in the 'src' and 'src/res' directories.
2. Modify to your liking and save it.
3. Make sure you have crystal installed in your system by running:
   ```crystal --version```
4. To build it, run the following command:
   Building using `shardas`: ```shards build```
   Building with `compile`: ```sh compile```
5. Go to the 'bin' directory created inside the project and run ```./cbat```.

**Note:** Remember to give execution permissions to cbat: ```chmod +x cbat```.

# Dependencies
At the current version, none.

# Where is the data gathered from?
All the information is gathered from the ```/sys/class/power_supply/BAT*/capacity``` and ```/sys/class/power_supply/BAT*/status``` files. 
If your system saves the battery information in another directory, you might want to change the class attribute ```@supply_dir``` to the right directory for your system.

# How to run your cbat file
1. You can make a soft link to the cbat executable. Run in the terminal:
	```ln -s /absolute/path/to/cbat/ /usr/local/bin```
2. Place an alias in your `~/.bashrc` file.
   Just add the line: ```alias cbat='/path/to/cbat/'``` then, save and quit.
4. Source it: ```source ~/.bashrc```
5. Try running: ```cbat```
