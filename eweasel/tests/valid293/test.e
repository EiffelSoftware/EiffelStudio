class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			;({ARRAY [INTEGER_8]} <<1>>).do_nothing
			;({LIST [INTEGER_8]} <<1>>).do_nothing -- Error: wrong base class
			;({like x} <<1>>).do_nothing
			;({separate ARRAY [INTEGER_8]} <<1>>).do_nothing -- Error in SCOOP: separate type
			;(create {A [ARRAY [INTEGER_8]]}).f
		end

feature {NONE} -- Access

	x: detachable ARRAY [INTEGER_8]
			-- An acnhor with an array type.

end
