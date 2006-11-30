
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	
	make is
		do
		end

	value: INTEGER
	
	b: BOOLEAN

	try: BOOLEAN is
		local
			x: INTEGER
		do
		ensure
			$POSTCONDITION
		end
end
