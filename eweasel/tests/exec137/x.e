
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class X
inherit
	ANY
		redefine
			default_create
		end
create
	default_create

feature
	default_create is
		do
			a := 47
			b := "abc"
		end

	a: INTEGER
	b: STRING

	to_reference: ANY is
		do
		end

end
