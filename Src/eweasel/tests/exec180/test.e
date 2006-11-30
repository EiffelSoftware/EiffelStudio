
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	EXCEPTIONS

create
	make
feature
	make is
		local
			s: STRING
		do
			s := exception_trace
			print (s = Void); io.new_line
			print (exception_trace)
		end
	
end
