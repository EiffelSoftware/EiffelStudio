class TEST 
create
	make
feature

	make is
		local
			l_tuple: TUPLE [INTEGER]
			l_any: ANY
		do
			create l_tuple
			l_tuple.put_integer (1, 1)

			l_tuple := [1, Void]
			l_any := l_tuple.item (2)
		end

end
