class ENSURE_THEN_AS_B

inherit

	ENSURE_THEN_AS
		rename
			assertions as old_then_assertions
		undefine
			clause_name, put_clause_keywords,
			format_assertions
		end;

	ENSURE_AS_B
		undefine
			is_then
		select
			assertions
		end

feature

end -- class ENSURE_THEN_AS_B
