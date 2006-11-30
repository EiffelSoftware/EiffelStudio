
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST1
		redefine
			try
		end
	
creation
	make
feature

	make (args: ARRAY [STRING]) is
		do
			print (try (47)); io.new_line
		end
		
	try (n: INTEGER): INTEGER is
		do
			Result := precursor (47)
		end
		
end
