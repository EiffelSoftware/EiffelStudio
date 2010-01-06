
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- Compile class as is.
	-- Compiler dies with exception trace while freezing class TEST.
	-- Now, uncomment the second line of `make'.  
	-- Delete the project directory and start all over.  Run es3.
	--	Voila!  No exception trace.  I cannot explain this.
	
class 
	TEST
creation	
	make
feature
	
	make is
		local
			k: INTEGER;
			b: BOOLEAN;
		do
			b := True;
			from
				k := 1;
			variant
				30 - k
			until
				b
			loop
				k := k + 1;
			end
		end;
		
end
