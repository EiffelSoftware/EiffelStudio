class TEST
create
	make
feature
	
	make is
		local
			v: NATURAL_64
		do
			v := 0x7FFFFFFFFFFFFFFF
			f (v)
		end
		
	f (v: NATURAL_64) is
		do
			if v <= 0x7FFFFFFFFFFFFFFF then
				print ("Ok%N")
			else
				print ("Not Ok%N")
			end
		end
		
end
