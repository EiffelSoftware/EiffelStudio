
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1

create
	make
feature
	
	make
		do 
			create a;
		end
	
	try
		require
			precondition: a.b
		do
		end

	a: TEST2;
end
