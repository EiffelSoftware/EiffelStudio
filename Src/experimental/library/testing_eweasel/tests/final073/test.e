
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
	make
		local
			tried: BOOLEAN
			s: STRING
		do
			if not tried then
				print (Current.out)
			else
				s := exception_trace
				if s.substring_index ("TEST                _invariant", 1) <= 0 then
					print ("Wrong class listed for invariant violation.%N")
					print ("Trace is:%N")
					print (s)
				else
					print ("OK%N")
				end
			end
		rescue
			tried := True
			retry
		end

	b: BOOLEAN

invariant
	b

end
