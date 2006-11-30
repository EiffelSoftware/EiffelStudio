
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST3
feature	
	feat: BOOLEAN is
		require
			one: true
			two: false
		do
			io.putstring ("In TEST2 original feat%N");
			Result := True
		end;
end
