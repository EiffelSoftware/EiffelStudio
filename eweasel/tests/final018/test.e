
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class 
	TEST
creation
	make
feature
	
	make is
		do
			f (Void)
		end;
	
	f (x: NONE) is
		local
			y: NONE;
		do
			y := my_clone (x);
		end;

	my_clone (a: ANY): like a is
		do
			if a /= Void then
				Result := a.twin
			end
		end
end
