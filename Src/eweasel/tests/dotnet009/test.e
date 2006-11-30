class TEST

inherit
	TEST1

	MARSHAL_BY_REF_OBJECT
		rename
			make as old_make
		end

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
			routine_with_anchor
		end

end
