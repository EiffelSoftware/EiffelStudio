
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler dies with run-time PANIC.


class TEST
creation
	make
feature
	make is
		local
			i: INTEGER
			s: STRING
			mem: MEMORY
		do
			create mem
			print (once_tuple)
			from
				i := 0
			until
				i > 10000
			loop
				create s.make (10)
				i := i + 1	
			end
			once_tuple.put ("String", 2)
			mem.collect
			mem.collect
			print ("After is ")
			print (once_tuple)
			s ?= once_tuple.item (2)
	
			print (s.count)
			io.new_line
		end;
	
	once_tuple: TUPLE [INTEGER, ANY, ANY, INTEGER] is
			-- Once tuple.
		once
			create Result.make
			Result.put(1, 1)
			Result.put(12,4)
		end
	
end

