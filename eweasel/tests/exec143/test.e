
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
			a: ARRAY [ANY]
			int: INTERNAL
		do
			create a.make (1, 1)
			create int
			io.put_boolean (int.is_special_any_type (int.dynamic_type (a.area)))
			io.new_line
		end
			
	t: ARRAY [expanded TEST1]
end
