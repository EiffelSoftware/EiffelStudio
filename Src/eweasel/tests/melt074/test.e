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
		end
		
end
