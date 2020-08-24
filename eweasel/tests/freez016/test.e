
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	
	make
		do 
			create x
			x.weasel
			io.put_string (x.w.generating_type.name_32.to_string_8); io.new_line 
			create y
			y.weasel
			io.put_string (y.w.generating_type.name_32.to_string_8); io.new_line 
			create z
			z.weasel
			io.put_string (z.w.generating_type.name_32.to_string_8); io.new_line 
			create k
			k.weasel
			io.put_string (k.w.generating_type.name_32.to_string_8); io.new_line
		end;
	
	x: TEST1 [INTEGER_8]
	y: TEST1 [INTEGER_16]
	z: TEST1 [INTEGER]
	k: TEST1 [INTEGER_64]
end
