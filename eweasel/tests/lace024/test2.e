
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2
feature
	test2_try
		do
			io.putstring ("Entering test2_try%N");
			debug ("weasel")
				io.putstring ("TEST2 weasel%N");
			end
			debug ("wimp")
				io.putstring ("TEST2 wimp%N");
			end
		end

end
