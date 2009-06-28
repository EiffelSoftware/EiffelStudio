
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

deferred class TEST1
feature
	
	f is
		require
			precondition: show ("Precondition")
		deferred
		ensure
			postcondition: show ("Postcondition")
		end
			
	show (s: STRING): BOOLEAN is
		do
			io.put_string (s)
			io.new_line
			Result := True
		end
	
end
