
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler reports violation of
	-- VRLE even though `Result' appears in a function.

class 
	TEST
creation	
	make
feature
	
	make is
		do
		end;
	
	f: NONE is
		local
			x: NONE
		do
			Result := Void;
			-- x := Void;
		end
end
