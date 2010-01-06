
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2
create
	make
feature
	make is
		do
		end
	
	is_stopable: BOOLEAN is
		do
			print ("In TEST2 stopable%N")
			Result := True
		end
	
end
