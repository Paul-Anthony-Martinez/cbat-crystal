#!/bin/crystal

def run(cmd, arg)
   stdout = IO::Memory.new
   stderr = IO::Memory.new
   signal = Process.run(cmd, args: arg, output: stdout, error: stderr)

   return signal, stdout
end

def draw_bar(clvl)
   i = 0
   j = 0
   lvl = clvl.to_i
   floor = (lvl.to_i*20/100).round

   print "["
   while i < floor
      print "\u2588"
      i += 1
   end

   while j < 20
      print "\u2591"
      j += 1
   end

   print "]"
end

def print_info(clvl, status)
   lvl = clvl
   stat = status
   print "#{lvl}%" 
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

print_info(clvl, status)
draw_bar(clvl)
puts "\n"

exit 0
