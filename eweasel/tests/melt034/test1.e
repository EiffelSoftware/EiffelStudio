
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST1
inherit
	EXCEPTIONS
		redefine
			default_create
		end
creation
	default_create
feature
	default_create is
		do
			io.putstring ("In expanded class make%N");
			raise ("weasels");
		end

	d: DOUBLE;
	
end
