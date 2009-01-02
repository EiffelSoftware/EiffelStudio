
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> {NUMERIC, COMPARABLE}] 
inherit
	LINKED_LIST[COMPARABLE]
create
	make

convert
	to_linked_list: {TEST1[G]}
feature
	to_linked_list: TEST1[G]
		do
		end
end
