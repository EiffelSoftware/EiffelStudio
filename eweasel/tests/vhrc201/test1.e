
--| Copyright (c) 1993-2021 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature

	p0 alias "not": INTEGER is
		do
		end
		
	p1 alias "###", p2 alias "+": INTEGER;
		
	i1 alias "###" (b: BOOLEAN): INTEGER is
		once
		end
		
	i2 alias "+" (b: BOOLEAN): INTEGER is
		once
		end
		
	i3 alias "#free_operator" (b: like Current): like Current is
		external
			"C"
		alias
			"weasel"
		end
		
	old_feature (s: STRING): STRING is
		do
		end
	
	new_feature (s: INTEGER): INTEGER is
		do
		end
	
end
