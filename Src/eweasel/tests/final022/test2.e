
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class TEST2
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
		end

	to_reference: ANY is
		do
		end

	set_a (v: INTEGER) is
		do
			a := v
		end

	a: INTEGER
end
