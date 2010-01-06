
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make is
		local
			d: ARRAY [like c]
		do
			create d.make (1, 2)
			print ((<< c >>).generating_type); io.new_line
			try (d);
			try (<< c >>);
		end
	
	try (a: ARRAY [like c]) is
		do
			print (a.generating_type); io.new_line
		end
		
	c: expanded TEST1

end
