class TEST 
create
	make
feature

	make is
		local
			l_tuple: TUPLE [INTEGER]
		do
			create l_tuple
			l_tuple.put (5.0, 1)
		end

end

