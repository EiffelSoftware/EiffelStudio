
expanded class TEST2
feature
	try
		local
			x: like {TEST2}.value
		do
			print (x.weasel); io.new_line
		end
	
	value: like Current
		do
		end
	
	weasel: INTEGER
end
