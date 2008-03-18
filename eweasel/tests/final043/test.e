class TEST
create
	make

feature {NONE} -- Creation

	make
		local
			keys: TUPLE [name: TEST1; last: TEST1]
		do
			create keys
			keys.name := create {TEST1}
			keys.last := create {TEST1}
			print_values (keys.name, generate_garbage, keys.last)
			keys.name.f
		end


	print_values (a, b, c: ANY) is
			--
		do
			print (a) print ("%N")
			print (b) print ("%N")
			print (c) print ("%N")
		end

	generate_garbage: BOOLEAN is
			--
		local
			l_mem: MEMORY
		do
			create l_mem
			l_mem.collect
		end

end
