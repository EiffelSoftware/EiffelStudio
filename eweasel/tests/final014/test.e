
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
			p: PARENT;
			x: TEST1;
			y: TEST2;
		do 
			create {TEST1} p.make;
			io.put_integer (p.count); io.new_line ;
			create {TEST2} p.make;
			io.put_integer (p.count); io.new_line;
		end

end
