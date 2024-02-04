require "option_parser"
require "./info"

class Parser
   @info = Information.new
   def parse_args(props)
      OptionParser.parse() do |parser|
         parser.banner = @info.description
         parser.on "-w", "--width=_width", @info.width do |_width|
            props.spaces = _width.to_i()
         end
         parser.on "-h", "--help", @info.help do
            STDOUT.puts parser
            exit 0
         end
         parser.on "-v", "--version", @info.version do
            print @info.credits
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
