
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 
inherit 
	TEST2
		select
			f
		end;
	TEST2
		rename
			f as h
		export
			{NONE} f
		undefine
			f
		redefine
			f
		select
			f
		end
feature
end 


