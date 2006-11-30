
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

$HEADER_KEYWORD
class TEST
inherit
	TEST1
		redefine
			attribute, default_create
		end
		
creation
	make, default_create
feature	
	make, default_create is
		do
			try;
		end
	
	attribute: like Current;
	
end
