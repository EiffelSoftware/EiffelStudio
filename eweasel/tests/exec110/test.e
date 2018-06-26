
--| Copyright (c) 1993-2018 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

inherit
	MEM_CONST
	EXCEPTIONS

create
	make

feature
	
	make (args: ARRAY [STRING])
		local
			k, count: INTEGER
			s: STRING
		do
			create a.make_empty
			count := args [1].to_integer
			create mem.make (Eiffel_memory)
			from
				k := 1
			until
				k > count
			loop
				a := << 
					strip (), 
					strip (),
					strip ()
					>>
				check_memory
				k := k + 1
			end
		end

	a: ARRAY [ANY]
	
	mem: MEM_INFO

	threshold: INTEGER = 15_000_000

	check_memory
		do
			mem.update (Eiffel_memory)
			if mem.used > threshold then
				io.putstring ("Eiffel memory used is ")
				io.putint (mem.used)
				io.putstring (" bytes - probably have a memory leak%N")
				die (0)
			end
		end
	
end
