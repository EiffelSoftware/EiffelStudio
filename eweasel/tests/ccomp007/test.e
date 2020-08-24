
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is, using `es3 -finalize' and specifying
	--	`assertion (all)' in the Ace file.  
	-- Finish_freezing.  Generated C code won't compile.

note
	
class TEST

inherit
	TEST1
create
	
	make

feature  -- Creation

	make
		local
			s: STRING;
			b: BOOLEAN;
		do
			s := t.make_directory_name ("a", "b");
			b := t.valid_fd (0);
			s := t.compilation_flag;
		end;

end
