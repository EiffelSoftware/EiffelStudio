
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

-- To reproduce error:
-- Compile class as is.  Compiler says class is syntactically legal, 
-- even though `a' is declared with a Bit_type which has a positive
-- integer constant (construct Constant includes signed integers).

class TEST
creation
	make
feature
	make is
		do
		end;

	a: BIT +13;

end
