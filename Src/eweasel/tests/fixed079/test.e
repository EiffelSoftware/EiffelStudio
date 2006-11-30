
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class 
	TEST
creation	
	make
feature
	
	ab: STRING;
	______abc: STRING;

	make is
		do
			abc := "Hey";
			io.putstring (abc); io.new_line;
			io.putstring (_abc); io.new_line;
			_____abc := "little";
			io.putstring (_____abc); io.new_line;
			______________________abc := "weasel";
			io.putstring (______________________abc); io.new_line;
		end;
		
end
