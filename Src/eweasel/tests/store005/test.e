
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
			l_file: RAW_FILE
		do
			tuple_int := [32]
			create l_file.make ("test.store")
			l_file.open_write
			l_file.independent_store (Current)
			l_file.close
		end

	tuple_int: TUPLE [INTEGER]
	
end
