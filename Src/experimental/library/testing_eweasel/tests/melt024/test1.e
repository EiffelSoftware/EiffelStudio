
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G]
creation
	make
feature
	make (xval: G) is
		do
			x := xval;
		end;

	x: G

	try is
		do
			(<< x >>).print ("Weasel%N");
		end
end
