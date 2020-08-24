
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class CHILD1
inherit
	PARENT
feature
	weasel
		do
			io.put_string ("In CHILD1 weasel%N")
		end
end
