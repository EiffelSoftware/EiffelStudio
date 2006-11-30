
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class SHARED
feature
	ok: BOOLEAN_REF is
		once
			!!Result;
		end;

	set_ok is
		do
			ok.set_item (True);
		end
	
	unset_ok is
		do
			ok.set_item (False);
		end
end
