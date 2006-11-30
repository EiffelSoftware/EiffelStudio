
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit EXCEPTIONS	-- Semicolon not optional
	MEMORY
feature
	test_me(x: INTEGER y: REAL) is	-- Semicolon not optional
		require
			x > 0	-- Semicolon not optional
			y > 0.0
		local
			z: REAL	-- Semicolon not optional
			w: INTEGER
		do
			z := y	-- Semicolon not optional
			w := x
		end	-- Semicolon not optional

	test_it is
		do
		end
end
