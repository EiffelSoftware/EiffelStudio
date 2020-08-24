
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST2 [G]
inherit
	ANY
		redefine
			default_create
		end
create
	default_create
feature
	default_create
		do
			io.putstring ("In creation procedure of TEST2%N");
		end;

	try
		do
			io.putbool (m = Void); io.new_line;
		end

	m: G

	to_reference: ANY
		do
		end

end
