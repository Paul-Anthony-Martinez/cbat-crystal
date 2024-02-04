require "dir"
require "./res/parse_args.cr"

class Cbat
   def initialize( @props : Properties ) end
   @supply_dir = "/sys/class/power_supply/"
   @files_list = [] of String
   @cap_paths = [] of String
   @stat_paths = [] of String
   @bat_capacity = [] of String
   @bat_status = [] of String
   @bat_bars = [] of String
   def run()
      list_batteries()
      get_values()
      create_bars()
      display_data()
   end
   def list_batteries()
      files = Dir.children(@supply_dir)
      files.each do |line|
         if /BAT*/.match(line)
            @files_list << line.to_s()
         end
      end
      @files_list.each do |file|
         @cap_paths << @supply_dir + file + "/capacity"
         @stat_paths << @supply_dir + file + "/status"
      end
   end
   def get_values()
      capacity = ""
      status = ""
      i = 0
      @files_list.each do |file|
         cap_path = @cap_paths[i]
         stat_path = @stat_paths[i]
         file = File.open(cap_path) do |file|
            @bat_capacity << file.gets_to_end().to_s()
         end
         file = File.open(stat_path) do |file|
            @bat_status << file.gets_to_end().to_s()
         end
         i += 1
      end
   end
   def create_bars()
      i = 0
      @files_list.each do |line|
         capacity = @bat_capacity[i].to_i()
         floor = (capacity * @props.@spaces / 100).round()
         bar = ""
         b = 0
         while b < floor
            bar += "#{@props.@fill_color}#{@props.@fill_char}\e[0m"
            b += 1
         end
         while b < @props.@spaces
            bar += "#{@props.@empty_color}#{@props.@empty_char}\e[0m"
            b += 1
         end
         @bat_bars << bar
         i += 1
      end
   end
   def display_data()
      i = 0
      @files_list.each do |line|
         print("#{line}#{@props.item_separator}")
         print("[#{@bat_bars[i].strip()}]#{@props.item_separator}")
         print("[#{@bat_capacity[i].strip()}%]#{@props.item_separator}")
         print("[#{@bat_status[i].strip()}]")
         i += 1
      end
      print "\n"
   end
end

struct Properties
   property spaces = 20
   property item_separator = ""
   property fill_char = "\u2588"
   property fill_color = "\e[32m"
   property empty_char = "\u2591"
   property empty_color = "\e[31m"
end 

props = Properties.new
parse = Parser.new
props = parse.parse_args(props)
cbat = Cbat.new(props).run()
