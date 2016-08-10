
start = 2
n = 7

amount = (2..n).to_a
all = []
all2 = {}


loop do

amount.each do |x|

	if start != x && !all2.map{|x,y| y}.include?([start,x].sort!)
		prod = start*x
		try = [start, x, prod]
		if try.join.count("#{start}") == 1 && try.join.count("#{x}") == 1 && try.join.count("0") == 0
			all2[prod] = [start,x].sort!
		end
	end

end

start+=1

break if start > n

end

puts all2