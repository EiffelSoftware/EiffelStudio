--| Copyright (c) 1993-2021 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

inherit CHILD_CLASS

create
	make

feature
	make
		do
			if attached {PARENT_CLASS} Current then
				print ("CONFORMANCE%N")
			else
				print ("NONCONFORMANCE%N")
			end
		end
end
