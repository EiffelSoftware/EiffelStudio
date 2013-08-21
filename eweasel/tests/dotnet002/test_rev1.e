class TEST 
create
	make
feature

	make is
		local
			l_tuple: TUPLE [INTEGER]
		do
			l_tuple := [0]
			l_tuple.put (5.0, 1)
		end

end

