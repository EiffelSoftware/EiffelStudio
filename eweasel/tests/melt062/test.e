
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	EXCEPTIONS
create
	make
feature
	make
		local
			tried: BOOLEAN
			s: SEQ_STRING
		do
			if not tried then 
				create x;
				x.test_me;
			end
		rescue
			create s.make (0)
			s.append (exception_trace)
			s.start
			s.search_string_after ("Invalid_object", 0);
			if s.after then
				tried := True
				retry
			end;
		end
	
	x: TEST2;
end
