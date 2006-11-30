
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	EXCEPTIONS
creation
	make
feature
	make is
		local
			tried: BOOLEAN
			s: SEQ_STRING
		do
			if not tried then
				!!x;
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
