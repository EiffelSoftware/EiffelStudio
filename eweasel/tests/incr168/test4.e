
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST4
feature	
	$FUNCTION: BOOLEAN is
		require
		do
			io.putstring ("In TEST4 original feat%N");
			Result := True
		end;
end


