
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	
	make
		local
			b: BOOL_STRING;
		do 
			create b.make (0);
			io.putstring ("All done%N");
		end;

end 
