class ENSURE_AS

inherit

	ASSERT_LIST_AS
		redefine
			clause_name
		end
		

feature

	is_then: BOOLEAN is
			-- Is the assertion list an ensure then part ?
		do
			-- Do nothing
		end;

feature {}
	
	clause_name(ctxt: FORMAT_CONTEXT): STRING is
			-- "ensure" or "ensure then"
		do
			if is_then then
				Result := "ensure"
			else
				Result := "ensure then"
			end
		end ;
			

end
