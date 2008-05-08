class TEST
create
	make

feature {NONE} -- Creation

	make
		local
			keys: TUPLE [name: TEST1; last: TEST1]
			l_str: STRING
			i: INTEGER
		do
			create keys
			keys.name := create {TEST2}
			keys.last := create {TEST2}
			print_values (keys.name, generate_garbage, keys.last)
			keys.name.f
			from
				i := 1
			until
				i = 2
			loop
				keys.twin.name.f
				keys.twin.name.h (l_str)
				i := i + 1
			end
		end


	print_values (a, b, c: ANY) is
			--
		do
			print (a.generating_type) print ("%N")
			print (b.generating_type) print ("%N")
			print (c.generating_type) print ("%N")
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
