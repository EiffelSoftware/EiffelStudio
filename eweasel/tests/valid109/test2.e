
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2 [G, H -> TEST4]
create
	make
feature
	make
		do 
			create b;
		end

	b: TEST3 [H, LIST [G]];
	
end
