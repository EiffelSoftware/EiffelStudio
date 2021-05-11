
--| Copyright (c) 1993-2021 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature

	p1 alias "not": INTEGER is
		do
		end
		
	p2 alias "###", p3 alias "+", p4 alias "#weasel", p5 alias "###weasel": INTEGER;
		
	i1 alias "###" (b: BOOLEAN): INTEGER is
		once
		end
		
	i2 alias "+" (b: BOOLEAN): INTEGER is
		once
		end
		
	i3 alias "#weasel", i4 alias "###weasel" (b: like Current): like Current is
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
