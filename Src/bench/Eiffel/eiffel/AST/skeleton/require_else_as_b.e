class REQUIRE_ELSE_AS_B

inherit

	REQUIRE_ELSE_AS
		undefine
			clause_name, put_clause_keywords,
			reset, format_assertions
		select
			assertions
		end;

	REQUIRE_AS_B
		rename
			assertions as old_else_assertions
		undefine
			is_else
		end

feature

end -- class REQUIRE_ELSE_AS_B
