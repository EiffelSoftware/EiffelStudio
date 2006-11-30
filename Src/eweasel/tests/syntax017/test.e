
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler won't accept standard operator
	-- name which has one or more characters in uppercase.

class TEST
	
creation
	make
feature
	
	make is
		do
			print (Current OR Current); io.new_line;
			print (Current AND Current); io.new_line;
		end;

	infix "OR" (arg: like Current): like Current is
		do
			io.putstring ("In OR%N");
		end;
	
	infix "aNd" (arg: like Current): like Current is
		do
			io.putstring ("In OR%N");
		end
end

