
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	-- 	Divide by zero does not cause an exception and
	--	the real number printed is `Inf'.

class TEST

creation
	make
feature

	make is
		local
			x, real_zero: REAL_32;
			n: INTEGER;
		do
			if n = 0 then
				real_zero := {REAL_32} 0.0;
				x := {REAL_32} 1.0 / real_zero;
				print (x); io.new_line;
				io.putreal (x); io.new_line;
				io.putstring ("Got past divides by zero%N");
			end
		rescue
			io.putstring ("In rescue clause%N");
		end;

end


