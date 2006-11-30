
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
			l_int: INTERNAL
		do
			create l_int
			io.put_boolean (
				l_int.dynamic_type_from_string ("TEST") = l_int.dynamic_type (Current))
			io.put_new_line
		end
	
end
