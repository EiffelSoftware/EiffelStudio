
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Generated C code
	--	for this class won't compile.

class TEST
	
creation
	make
feature

	make is
		local
			b1: BOOLEAN;
		do
			print (true implies true); io.new_line;
			print (true implies false); io.new_line;
			print (true implies b1); io.new_line;
			print (true implies b2); io.new_line;
			print (true implies b3); io.new_line;
			
			print (false implies true); io.new_line;
			print (false implies false); io.new_line;
			print (false implies b1); io.new_line;
			print (false implies b2); io.new_line;
			print (false implies b3); io.new_line;
			
			print (b1 implies true); io.new_line;
			print (b1 implies false); io.new_line;
			print (b1 implies b1); io.new_line;
			print (b1 implies b2); io.new_line;
			print (b1 implies b3); io.new_line;
			
			print (b2 implies true); io.new_line;
			print (b2 implies false); io.new_line;
			print (b2 implies b1); io.new_line;
			print (b2 implies b2); io.new_line;
			print (b2 implies b3); io.new_line;
			
			print (b3 implies true); io.new_line;
			print (b3 implies false); io.new_line;
			print (b3 implies b1); io.new_line;
			print (b3 implies b2); io.new_line;
			print (b3 implies b3); io.new_line;
		
		end;

	b2: BOOLEAN;
	
	b3: BOOLEAN is
		do
		end;
end

