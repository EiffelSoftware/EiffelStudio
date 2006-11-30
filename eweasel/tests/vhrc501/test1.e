
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature

	prefix "not": INTEGER is
		do
		end
		
	prefix "###", prefix "+": INTEGER;
		
	infix "###" (b: BOOLEAN): INTEGER is
		once
		end
		
	infix "+" (b: BOOLEAN): INTEGER is
		once
		end
		
	infix "@free_operator" (b: like Current): like Current is
		external
			"C"
		alias
			"weasel"
		end
		
	feature1 (s, t: STRING): STRING is
		do
		end
	
	feature2: STRING is
		do
		end
	
	feature3 (s, t: STRING) is
		do
		end
	
	feature4 (s: STRING) is
		do
		end
	
	feature5 is
		do
		end
	
end
