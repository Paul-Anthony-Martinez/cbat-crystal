struct Information
   property description = "Usage: cbat [OPTION]...\
   \nA minimal Crystal program to show your battery status.\
   \nWithout arguments, output will be: [%n][%p][%b][%c]\
   \n\nOptions:"
   property width = "Sets the amount of space for the bar to display."
   property color = "Enables color in the bar output."
   property format_str = "Receives a string that specifies how information will \
   \nbe returned. Variables are specified with a % and a letter:\
   \n\t'%b' for the bar\t'%p' for percentage\
   \n\t'%n' for battery name\t'%s' for charging status."
   property help = "Display this help menu."
   property version = "Display the current installed version of CBat."
   property credits = "CBAT 0.1 (13.4.2024)\n\nProgrammed by \
   Pablo Martínez & Emanuel Avilés.\n"
end
