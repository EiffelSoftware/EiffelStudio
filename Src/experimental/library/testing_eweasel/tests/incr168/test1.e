
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature	
	feat: BOOLEAN is
		require
			possible: false
		do
			io.putstring ("In TEST1 original feat%N");
			Result := True
		end;
end
