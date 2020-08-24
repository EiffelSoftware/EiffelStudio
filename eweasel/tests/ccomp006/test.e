
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce problem:
	-- Compile class as is, using `es3 -F' to finalize.
	-- Finish_freezing.  Link fails due to undefined symbols.

class TEST
create
	make
feature
	make
		local
			s: STRING
		do 
			create s.make (0);
		end;
		

end

