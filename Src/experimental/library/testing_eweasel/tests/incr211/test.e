
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST2
		redefine
			default_rescue
		end
	$PARENT

create 
	make
feature
	make is
		do
		end

	default_rescue is
		do
			Precursor {ANY}
			Precursor {TEST2}
		rescue
			default_rescue
		end
end

