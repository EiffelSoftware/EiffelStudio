
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature
	self_ref: TEST1 is
		do
			Result := Current;
		end;

	string: STRING;
	
	set_string (new: STRING) is
		do
			string := new;
		end
end
