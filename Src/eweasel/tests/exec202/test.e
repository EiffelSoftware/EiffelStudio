
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	EXCEPTIONS
creation
	make
feature
	
	make is
		local
			tried: BOOLEAN
		do
			if not tried then
				try
			else
				print (is_developer_exception_of_name (value))
				io.new_line
			end
		rescue
			tried := True
			retry
		end
			
	try is
		do
			raise (value)
		end;
			
	value: STRING is "weasel %/0/ stoat"
			
end
