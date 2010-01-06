
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
	default_create,
	make

feature
	default_create is
		do
			!!a.make (0);
			a.append ("weasel");
			b := {REAL_32} 3.14159;
		end;

	make (arg: TEST1) is
		do
			a := arg.a
			b := arg.b
		end


	a: STRING;
	b: REAL;
end
