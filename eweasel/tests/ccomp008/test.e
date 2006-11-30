
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is, using `es3 -finalize' and specifying
	--	`assertion (no)' in the Ace file.  Do not use precompilation,
	--	but allow dead code removal to be done.
	-- Finish_freezing.  Generated C code won't compile.

class TEST
creation
	make
feature
	
	make is
		local
			a: LINKED_LIST [STRING];
		do
			!!s.make (a);
		end;
	
	s: TEST1
end 
