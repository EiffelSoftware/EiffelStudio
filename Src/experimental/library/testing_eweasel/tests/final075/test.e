
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create
        make

feature

        make
                do
			create c.make_from_parent (p)
			create p
			try (p)
                end

	try (a: CHILD)
		do
			print (a.turkey); io.new_line
		end
		     
	p: PARENT
	
	c: CHILD
	
end
