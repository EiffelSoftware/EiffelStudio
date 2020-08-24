
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST3 [G -> TEST4, H -> LIST [G]]
feature
	c: G;
	d: H;
	
	try (a: G; b: H)
		do
			c := a;
			d := b;
			d.extend (c);
			d.start;
			io.putstring ("Calling wimp%N");
			d.item.wimp;
		end
end
