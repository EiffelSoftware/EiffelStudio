
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
inherit
	ANY
		redefine
			default_create
		end
creation
	default_create
feature
	default_create is
		do
			io.putstring ("In TEST1 make%N");
			value := 47;
		end

	value: INTEGER;

	show (b: BOOLEAN; s: STRING): BOOLEAN is
		do
			io.putstring ("Checking invariant ");
			io.putstring (s); io.new_line;
			Result := b;
		end
invariant
	inv1: show (value = 47, "inv1");
end
