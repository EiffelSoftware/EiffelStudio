
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	INTERNAL
create make
feature
	make is
		local
			t1: TEST1
			t2: TEST2
		do
			create t1
			create t2
			print (type_conforms_to (dynamic_type (t1), dynamic_type (t2)))
			io.new_line
			print (type_conforms_to (dynamic_type (t2), dynamic_type (t1)))
			io.new_line
		end
end

