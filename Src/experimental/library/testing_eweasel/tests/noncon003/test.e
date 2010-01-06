
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

$CONFORMING_INHERITANCE_CLAUSE

$NON_CONFORMING_INHERITANCE_CLAUSE

create
	make

feature
	make
		do
			if {x: !NON_CONFORMING_CLASS} Current then
				print ("CONFORMANCE%N")
			else
				print ("NONCONFORMANCE%N")
			end
		end
end 
