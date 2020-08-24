
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature
	try: TEST1
		do 
			create s.make (100);
			s.append ("weasel");
			Result := Current;
		end;

	s: STRING;
end
