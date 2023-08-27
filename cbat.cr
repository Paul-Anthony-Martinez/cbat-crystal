#!/bin/crystal
require "file"
require "dir"

# method that lists directories containing battery information and returns them in a list
def list_batteries(supply_dir)
   files = Dir.children(supply_dir)
   files_list = Array(String).new
   files.each do |line|
      if /BAT*/.match(line)
         files_list << line.to_s
      end
   end
   return files_list
end

# method that appends the /capacity and /status subdirectories to the path of the batteries in the list
def cat_path(supply_dir, files_list)
   cap_paths = Array(String).new
   stat_paths = Array(String).new
   # when iterating, line contains the name of the present element in the array
   files_list.each do |line|
      cap_paths << supply_dir + line + "/capacity"
      stat_paths << supply_dir + line + "/status"
   end
   return cap_paths, stat_paths
end

# method that gets the corresponding status and capacity string using the cap_paths and stat_paths arrays.
def get_values(supply_dir, files_list, cap_paths, stat_paths)
   bat_capacity = Array(Int32).new()
   bat_status = Array(String).new()
   i = 0
   files_list.each do |bat|
      capacity = 0
      status = ""
      cap_path = cap_paths[i]
      stat_path = stat_paths[i]
      file = File.open(cap_path) do |file|
         capacity = file.gets_to_end()
      end
      file = File.open(stat_path) do |file|
         status = file.gets_to_end()
      end
      bat_capacity << capacity.to_i()
      bat_status << status.to_s()
      i += 1
   end
   return bat_capacity, bat_status
end

# when iterating to each battery we calculate floor of the capacity times the amount of spaces for the bar divided by a 100
# each bar is stored in a string and then, when moving to the next battery, the current string is stored in the array.
# the bar is drawn by first drawing the amount of bars representing the current capacity, then the rest by using the same variable in the next while loop.
def draw_bar(spaces, files_list, bat_capacity)
   i = 0
   bat_bars = Array(String).new()
   files_list.each do |line|
      capacity = bat_capacity[i].to_i()
      floor = (capacity * spaces/ 100).round()
      bar = "" 
      b = 0
      while b < floor
         bar += "\u2588"
         b += 1
      end
      while b < spaces
         bar += "\u2591"
         b += 1
      end
      bat_bars << bar
      i += 1
   end
   return bat_bars
end

# to display the data, we just iterate though each battery in the array and use print
def display_data(files_list, bat_status, bat_capacity, bat_bars)
   i = 0
   files_list.each do |line|
      print "<#{line}>"
      print "\t[#{bat_bars[i].strip()}] [#{bat_capacity[i]}%] [#{bat_status[i].strip()}]"
      i += 1
   end
   print "\n"
end

spaces = 20
supply_dir = "/sys/class/power_supply/"
files_list = list_batteries(supply_dir)
cap_paths, stat_paths = cat_path(supply_dir, files_list)
bat_capacity, bat_status = get_values(supply_dir, files_list, cap_paths, stat_paths)
bat_bars = draw_bar(spaces, files_list, bat_capacity)
display_data(files_list, bat_status, bat_capacity, bat_bars)
