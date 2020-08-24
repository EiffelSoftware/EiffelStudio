
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class SHARED
feature
	ok: BOOLEAN_REF
		once 
			create Result;
		end;

	set_ok
		do
			ok.set_item (True);
		end
	
	unset_ok
		do
			ok.set_item (False);
		end
end
