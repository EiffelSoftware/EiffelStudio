
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
			try (1, 2, 3, 4, 5);
      		end;
     
   	try (a, b, c, d, e: INTEGER) is
		external "C (long, float, int * (*) (long, float, void (*) (long, long)), struct weasel, enum wimp)"
      		end;
     
end
