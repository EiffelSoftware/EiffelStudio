
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	make is
		local
			tried: BOOLEAN
		do
			if not tried then
				f
			else
				print ("Precondition violated%N")
			end
		rescue
			tried := True
			retry
		end
	
	f is
		require
			fake: $PRECONDITION
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"printf(%"Success\n%");"
		end

end
