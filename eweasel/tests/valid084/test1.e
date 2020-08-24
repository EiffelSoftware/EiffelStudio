
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature
	try (n: INTEGER)
		require
			good_argument: $ASSERTION
		do
		end

feature {TEST1}

	f alias "+": BOOLEAN
		do
			Result := True;
		end
	
	g alias "^" (n: INTEGER): BOOLEAN
		do
			Result := True;
		end
	
	raised_to (n: INTEGER): BOOLEAN
		do
			Result := True;
		end
end
