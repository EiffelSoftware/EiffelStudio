
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class SHARED
feature
	show (s: STRING): BOOLEAN
		do
			io.putstring (s); io.new_line;
			Result := True;
		end
end
