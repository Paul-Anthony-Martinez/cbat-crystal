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
            puts info.examples
				exit 0
         end
			parser.on "--fill-char=_char", info.fill_char do |_fchar|
				props.fill_char = _fchar;
			end
			parser.on "--empty-char=_char", info.empty_char do |_echar|
				props.empty_char = _echar.to_s().strip();
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
