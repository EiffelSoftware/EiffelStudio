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
	
	clause_name (ctxt: FORMAT_CONTEXT): STRING is
			-- require or require else
		do
			if ctxt.first_assertion then
				Result := "require"
			else
				Result := "require else"
			end
		end;
			

end
