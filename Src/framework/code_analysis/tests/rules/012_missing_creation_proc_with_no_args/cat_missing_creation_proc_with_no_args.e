class
	CAT_MISSING_CREATION_PROC_WITH_NO_ARGS

create
	make_with_int, make_with_bool

feature {NONE} -- Test

	-- Violates the code analysis rule for missing creation procedures with no arguments.

	make_with_int (a_int: INTEGER)
		do
			i := a_int
		end

	make_with_bool (a_bool: BOOLEAN)
		do
			b := a_bool
		end

feature -- Attributes

	i: INTEGER
	b: BOOLEAN
end
