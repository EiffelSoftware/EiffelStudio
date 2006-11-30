
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  

class TEST

creation
	make
feature

	make is
		do
			print (Current #\ 1); io.new_line;
			debug ("Debug 1%"")
				io.putstring ("Hi");
			end;
			debug ("Debug 2\")
				io.putstring ("Hi");
			end;
		end;

	infix "#\" (arg: INTEGER): INTEGER is
		do
			Result := arg + 2;
		end;

end
