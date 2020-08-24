
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST1
inherit	
	EXCEPTIONS
		redefine
			default_create
		end
create
	default_create
feature
	default_create
		do
			raise ("weasels");
		end
	
	wimp: INTEGER;
end
