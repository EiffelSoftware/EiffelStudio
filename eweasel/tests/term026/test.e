
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Invalid generic derivation causes compiler 
	--	exception trace.

class TEST

create
	make
feature

	make
		local
			x: ARRAY [INTEGER];
		do 
			create {ARRAY} x.make (1, 10);
		end;

end
