
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
feature

	to_any: ANY is
		do
			Result := Current
		end

	default_create is
		do
			x1 := 47.25E-99
			x2 := -1838332247
			x3 := 'W'
			x4 := True
			x5 := 127
			x6 := 32767
			x7 := $default_create
			x8 := {REAL_32} -47.29383
			x9 := 123456789012345
			x10 := once "TEST2"
		end

	x1: DOUBLE
	x2: INTEGER
	x3: CHARACTER
	x4: BOOLEAN
	x5: INTEGER_8
	x6: INTEGER_16
	x7: POINTER
	x8: REAL
	x9: INTEGER_64
	x10: STRING
	$EXTRA_ATTRIBUTE
end
