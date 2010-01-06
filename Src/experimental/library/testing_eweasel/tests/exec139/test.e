
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create 
	make
feature
	make is
		local
			a, retrieved_a: A
			l_raw: RAW_FILE
		do
			create a
			a.b1.set_i (28)
			a.b2.set_i (32)
			
			create l_raw.make_open_write ("toot")
			l_raw.independent_store (a)
			l_raw.close
			
			create l_raw.make_open_read ("toot")
			retrieved_a ?= l_raw.retrieved
			l_raw.close

			print (retrieved_a.b1.i); io.new_line
			print (retrieved_a.b2.i); io.new_line
			print (deep_equal (a, retrieved_a)); io.new_line
		end
end
