
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class SHOW
feature
	show (s: STRING; b: BOOLEAN): BOOLEAN is
		do
			io.putstring (s);
			io.new_line;
			if count.item > 0 then
				Result := b;
			else
				Result := True;
			end;
			count.set_item (count.item - 1);
		end;

feature {NONE}

	count: INTEGER_REF is
		once
			!!Result;
		end
end
