
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make is
		do
			io.putint (try.value); io.new_line;
		end;

	try: TEST1 is
		local
			x: TEST1;
		do
			Result := x;
		end;

end
