
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make is
		do
			Current.try;
		end

	try is
		require
			show ("Precondition", True);
		local
			m: expanded TEST1;
		do
			io.putint (m.value); io.new_line;
		ensure
			show ("Postcondition", old show ("Old expression", True));
		end

	show (s: STRING; b: BOOLEAN): BOOLEAN is
		do
			io.putstring (s); io.new_line;
			Result := b;
		end
invariant
	show ("Invariant", True);
	
end
