
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  C code for this
	--	class won't compile.

class TEST

creation
	make
feature

	make is
		local
			k: INTEGER;
			x: REAL;
		do
			x := {REAL_32} 1.0 / {REAL_32} 0.0;
			k := 1 // 0;
			print (x); io.new_line;
			io.putreal (x); io.new_line;
			print (k); io.new_line;
			io.putint (k); io.new_line;
			io.putstring ("Got past divides by zero%N");
		rescue
			io.putstring ("In rescue clause%N");
		end;

end


