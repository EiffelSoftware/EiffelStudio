
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

-- To reproduce the error:
-- Compile classes as is.
-- Then uncomment both occurrences of "deferred" and comment out
-- the "do" in the body of `a', making `a' (and this class) deferred.
-- Then run es3 again.

deferred class TEST1
feature	
	a: INTEGER is
		deferred
		end;
end 
