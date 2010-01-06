
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create
	make

feature -- Initialization

	make is
		local
			f: RAW_FILE
			a: ANY
			retried: BOOLEAN
		do
			if not retried then
				create f.make_open_read ("$CORRUPTED_FILE")
				a ?= f.retrieved
				f.close
				print ("Success where it should not happen%N")
			else
				f.close
				print ("Failed to read corrupted file%N")
			end
		rescue
			retried := True
			retry
		end 
		
end
