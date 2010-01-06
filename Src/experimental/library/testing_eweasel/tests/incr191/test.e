
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
			try
		end;
		
	try is
		require
			is_valid: is_valid
		do
		end

	is_valid: BOOLEAN is
		do
			io.put_string ("Checking precondition")
			io.new_line
			Result := True
		end
end
