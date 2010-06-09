
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	THREAD_CONTROL
	MEMORY
creation
	make

feature

	make (args: ARRAY [STRING]) is
		local
			depth, count: INTEGER
			worker1: WORKER1
			worker2: WORKER2
			worker3: WORKER3
			list: ARRAYED_LIST [STRING]
		do
			depth := args.item (1).to_integer
			count := args.item (2).to_integer
			create list.make (2)
			list.extend ("stoat_test")
			list.extend ("ermine_test")
			create worker1.make (depth, count, "weasel_test", list)
			create list.make (2)
			list.extend ("weasel_test")
			list.extend ("ermine_test")
			create worker2.make (depth, count, "stoat_test", list)
			create list.make (2)
			list.extend ("weasel_test")
			list.extend ("stoat_test")
			create worker3.make (depth, count, "ermine_test", list)
			worker1.launch
			worker2.launch
			worker3.launch
			join_all
		end;

end

