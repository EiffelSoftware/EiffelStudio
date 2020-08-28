
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler accepts class even though
	-- it does not seem to be legal.

class 
	TEST
create
	make
feature

	make
		do
			$INSTRUCTION
		end

	test1
		do
		end
end

