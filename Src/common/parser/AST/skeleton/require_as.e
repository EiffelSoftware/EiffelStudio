class REQUIRE_AS

inherit

	ASSERT_LIST_AS
		redefine
			clause_name
		end

feature -- Conveniences

	is_else: BOOLEAN is
			-- Is the assertion list a require else ?
		do
			-- Do nothing
		end;

feature {}
	
	clause_name: STRING is
			-- require or require else
		do
			if is_else then
				Result := "require else"
			else
				Result := "require"
			end
		end;
			

end
