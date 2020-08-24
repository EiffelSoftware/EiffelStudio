
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler accepts invalid generic
	--	derivation as creation type.

class TEST

create
	make
feature

	make
		local
			x: STRING;
		do 
			create {STRING [STRING]} x.make (1);
		end;

end
