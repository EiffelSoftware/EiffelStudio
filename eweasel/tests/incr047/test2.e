
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2
inherit
	ANY
		redefine
			default_create
		end
create
	default_create
feature
	default_create
		do
			m := {REAL_32} 3.14159;
		end;

	m: REAL;
	
	try
		do
			io.putstring ("In try%N");
		end;

	to_expanded: TEST2
		do
			create Result
		end
end
