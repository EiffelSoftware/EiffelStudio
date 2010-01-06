
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class SHARED
feature
	show (s: STRING): BOOLEAN is
		do
			io.putstring (s); io.new_line;
			Result := True;
		end
	
end
