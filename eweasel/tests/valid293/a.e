class A [G -> ARRAY [INTEGER_8]]

feature -- Basic operation

	f
			-- Run test.
		do
			;({G} <<1>>).do_nothing -- Error: non-array base class
			;({like x} <<1>>).do_nothing -- Error: non-array base class
		end

feature {NONE} -- Access

	x: detachable G
			-- An acnhor with an array type.

end
