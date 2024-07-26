require "./parse_args.cr"

class Cbat
   def initialize(@props : Properties)end
   @supply_dir = "/sys/class/power_supply/"
   @files_list = [] of String
   @cap_paths = [] of String
   @stat_paths = [] of String
   @bat_capacity = [] of String
   @bat_status = [] of String
   @bat_bars = [] of String
	# Once called, runs the class methods in order
   def run()
      list_batteries()
      get_values()
      create_bars()
      display_data()
   end
   # Looks for directories assigned to batteries in /sys/class/power_supply
	# Creates the path to the capacity and status files inside each one.
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
   # Reads /sys/class/power_supply/capacity and status for each battery
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
   # For each battery rounds its percentage and fills a string that contains the bar characters.
	# applies color if enabled.
	def create_bars()
      i = 0
      @files_list.each do |line|
         capacity = @bat_capacity[i].to_i()
         floor = (capacity * @props.@spaces / 100).round()
         bar = ""
         b = 0

         if @props.@color
            bar += "#{@props.@fill_color}"
         end

         while b < floor
            bar += "#{@props.@fill_char}"
            b += 1
         end

         if @props.@color
            bar += "\e[0m"
         end

         if @props.@color
            bar += "#{@props.@empty_color}"
         end

         while b < @props.@spaces
            bar += "#{@props.@empty_char}"
            b += 1
         end

         if @props.@color
            bar += "\e[0m"
         end

         @bat_bars << bar
         i += 1
      end
   end
   
	# Loops through each char in the format string and appends
	# the corresponding values into an array to print.
	def display_data()
      str = @props.@format
      tk = str.strip()
      tk_arr = tk.chars()
      out_str = ""

      j = 0
      while j < @files_list.size()
         i = 0
         while i < tk_arr.size()
            if tk_arr[i] === '%'
               if !tk_arr[i+1].nil?
                  if tk_arr[i + 1] === 'n'
                     out_str += @files_list[j].strip()
                  elsif tk_arr[i + 1] === 'b'
                     out_str += @bat_bars[j].strip()
                  elsif tk_arr[i + 1] === 'p'
                     out_str += "#{@bat_capacity[j].strip()}\%"
                  elsif tk_arr[i + 1] === 'c'
                     out_str += @bat_status[j].strip()
                  end
                  i += 1
               end
            else
               out_str += tk_arr[i]
            end
            i += 1
         end
         j += 1
      end
      puts out_str
		puts @props.fill_char
		puts @props.empty_char
   end
end

# Holds variables to control the output
# an instance is sent to the arguments parser
struct Properties
   property spaces = 20 # Amount of characters the bar will have
   property color = false # Enables a colored bar
   property format = "[%n][%p][%b][%c]" # Default output format: [name][percentage][ascii bar][status]
	property fill_char = "\u2588" # Unicode for a full block █
   property fill_color = "\e[32m" # Color green
   property empty_char = "\u2591" # Unicode for a light shade block ░
   property empty_color = "\e[31m" # Color red
end

props = Properties.new()
parser = Parser.new()
props = parser.parse_args(props)
cbat = Cbat.new(props).run()
