require "option_parser"
require "./res/info.cr"

class Parser
   def parse_args(props)
      info = Information.new()
      OptionParser.parse() do |parser|
         parser.banner = info.description;
         parser.on "-w", "--width=_width", info.width do |_width|
            props.spaces = _width.to_i();
         end
         parser.on "-s", "--string-format=_str", info.format_str do |_str|
            props.format = _str.to_s().strip();
         end
         parser.on "-c", "--color", info.color do
            props.color = true;
         end
         parser.on "-h", "--help", info.help do
            STDOUT.puts parser
            puts "\nExample:\
                  \nProduce the following output: [BAT0][███████████████████░]: Charging\
                  \n  cbat -s '[%n][%b]: %c'\
                  \nPrint the current battery status with a width of 15 characters:\
                  \n  cbat -w 15 or cbat -w 15 -s '[%n][%b]: %c'"
            exit 0
         end
			parser.on "--fill-char=_char", info.fill_char do |_char|
				props.fill_char = _char.to_s().strip();
			end
			parser.on "--empty-char=_char", info.empty_char do |_char|
				props.empty_char = _char.to_s().strip();
			end
         parser.on "-v", "--version", info.version do
            print info.credits
            exit 0
         end
         parser.invalid_option do |option_flag|
            STDOUT.puts parser
            exit 1
         end
         parser.parse()
      end
      return props
   end
end
