class REQUIRE_ELSE_AS_B

inherit

	REQUIRE_ELSE_AS
		redefine
			assertions
		end;

	REQUIRE_AS_B
		undefine
			is_else
		redefine
			assertions
		end

feature -- Properties

	assertions: EIFFEL_LIST_B [TAGGED_AS_B]

end -- class REQUIRE_ELSE_AS_B
