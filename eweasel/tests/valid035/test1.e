
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce problem:
	-- Compile classes as is.  Compiler reports violation of VJAR
	-- on the assignment below.

class 
	TEST1 [G, H -> NONE]
feature
	f is
		local
			g: G;
			h: H;
		do
			g := h;
			-- g := Void;
		end;

end
