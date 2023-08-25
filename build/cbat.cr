#!/bin/ruby

def run(cmd, arg)
   stdout = IO::Memory.new
   stderr = IO::Memory.new
   signal = Process.run(cmd, args: arg, output: stdout, error: stderr)

   return signal, stdout
end

def draw_bar(clvl)

   lvl = clvl.to_i
   floor = (lvl.to_i*20/100).round

   i = 0
   print "["
   while i < floor
      print "\u2588"
      i += 1
   end
   y = i
   while y < 20
      print "\u2591"
      y += 1
   end
   print "]"
   print " "
end

def print_info(clvl, status)
   lvl = clvl
   stat = status
   print "#{lvl}% " 
   print "[#{stat}]"
end

cmd = "cat"
fcap = ["/sys/class/power_supply/BAT0/capacity"]
fstat = ["/sys/class/power_supply/BAT0/status"]
signal, clvl = run(cmd, fcap)
signal = signal.to_s.to_i
clvl = clvl.to_s.strip

signal, status = run(cmd, fstat)
signal = signal.to_s.to_i
status = status.to_s.strip

draw_bar(clvl)
print_info(clvl, status)
puts "\n"

exit 0
