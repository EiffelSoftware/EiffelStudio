
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature
	
	weasel: INTEGER is
		require
			show ("Precondition of weasel");
		do
		ensure
			show ("Postcondition of weasel");
		end

	show (s: STRING): BOOLEAN is
		do
			io.putstring (s);
			io.new_line;
			Result := True;
		end;

invariant
	show ("Invariant of TEST1");
end
