
start = 2
n = 100

amount = (2..n).to_a
all = []
all2 = {}


loop do

amount.each do |x|

	if start != x && !all2.map{|x,y| y}.flatten.include?([start,x].sort!)
		prod = start*x
		#prod = prod.to_s.split("")[-1].to_i
		try = [start, x, prod]
		num = try.join.split("").to_a
		
		num = Hash[*num.inject(Hash.new(0)) {|h,v| h[v] += 1; h}.sort_by{|k,v| v}.reverse.flatten][0][1]
		puts num
		if try.join.count(num) == 1 && try.join.count("0") == 0
			
			all2[prod] ||= []
			again = [start,x].sort!
			all2[prod] << again if !all2[prod].include?(again)
		end
	end

end

start+=1

break if start > n

end

puts all2