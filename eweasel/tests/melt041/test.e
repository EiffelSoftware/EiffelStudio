
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
     
creation
	make
     
feature
     
   	make is
		local
			b: BIT Weasel_bits;
		do
			b := weasel (b);
			b := stoat (b);
      		end;
     
	Weasel_bits: INTEGER is 1_000_000

   	weasel (a: BIT Weasel_bits): BIT Weasel_bits is
		do
			Result := a;
      		end;
     
   	stoat (a: BIT 1_000_000): BIT 1_000_000 is
		do
			Result := a;
      		end;
     
end
