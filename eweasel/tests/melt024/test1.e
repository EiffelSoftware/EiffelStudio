
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G]
create
	make
feature
	make (xval: G)
		do
			x := xval;
		end;

	x: G

	try
		do
			(<< x >>).print ("Weasel%N");
		end
end
