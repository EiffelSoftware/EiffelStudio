
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	--	Produces incorrect output.
	
class 
	TEST
creation	
	make
feature
	
	make is 
		local
			b: BOOLEAN;
		do
			b := True;
			print (b); io.new_line;
			print (true); io.new_line;
			print (false); io.new_line;
			print (1); io.new_line;
			print (1.234); io.new_line;
			print ("Weasel"); io.new_line;
			print ('C'); io.new_line;
		end;

end
