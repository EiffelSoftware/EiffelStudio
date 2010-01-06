
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature
	try (n: INTEGER) is
		require
			good_argument: $ASSERTION
		do
		end

feature {TEST1}

	prefix "+": BOOLEAN is
		do
			Result := True;
		end
	
	infix "^" (n: INTEGER): BOOLEAN is
		do
			Result := True;
		end
	
	raised_to (n: INTEGER): BOOLEAN is
		do
			Result := True;
		end
end
