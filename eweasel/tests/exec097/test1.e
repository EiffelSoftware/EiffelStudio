
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> ANY]
create
	make
feature
	make
		do
			value1 := value2;
			io.putbool (value1 = value2); io.new_line;
			io.putbool (equal (value1, value2)); io.new_line;
		end

	value1: G;
	
	value2: G;
end
