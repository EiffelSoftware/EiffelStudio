
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature

	prefix "not": INTEGER is
		do
		end
		
	prefix "###", prefix "+", prefix "@weasel", prefix "###weasel": INTEGER;
		
	infix "###" (b: BOOLEAN): INTEGER is
		once
		end
		
	infix "+" (b: BOOLEAN): INTEGER is
		once
		end
		
	infix "@weasel", infix "###weasel" (b: like Current): like Current is
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
