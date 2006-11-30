
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make

feature

	make (args: ARRAY [STRING]) is
		do
			create x.make
			x.extend (create {TEST2})
			x.extend (create {TEST2})
			io.put_double (x.i_th (1).value); io.new_line
		end;

	x: LINKED_LIST [TEST2]
	
end
