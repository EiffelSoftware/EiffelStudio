
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
			b: TEST1 [TEST4]
			a: $TEST_TYPE
		do
			create b.make
			print (b.dummy_event_data.generating_type)
			io.new_line
			print (b.list.generating_type)
			io.new_line

			create a.make
			print (a.dummy_event_data.generating_type)
			io.new_line
			print (a.list.generating_type)
			io.new_line
		end

end
