class ENSURE_THEN_AS_B

inherit

	ENSURE_THEN_AS
		redefine
			assertions
		end;

	ENSURE_AS_B
		undefine
			is_then
		redefine
			assertions
		end

feature

	assertions: EIFFEL_LIST_B [TAGGED_AS_B]

end -- class ENSURE_THEN_AS_B
