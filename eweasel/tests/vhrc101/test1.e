
--| Copyright (c) 1993-2021 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature

	p1 alias "not": INTEGER is
		do
		end
		
	p2 alias "###": INTEGER;
		
	i1 alias "###" (b: BOOLEAN): INTEGER is
		once
		end
		
	i2 alias "#free_operator" (b: like Current): like Current is
		external
			"C"
		alias
			"weasel"
		end
		
	my_feature (s: STRING) is
		do
		end
	
end
