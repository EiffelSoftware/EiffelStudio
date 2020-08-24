
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  Compiler reports VGCC2, but 
	--	INTEGER is an effective class so there is no VGCC2 violation.

class TEST 
create
	make
feature
	
	make
		do 
			create {INTEGER} x;
		end;
	
	x: TEST1;
end

