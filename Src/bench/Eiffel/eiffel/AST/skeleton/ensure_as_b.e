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
	
	clause_name: STRING is
			-- "ensure" or "ensure then"
		do
			if is_then then
				Result := "ensure then"
			else
				Result := "ensure"
			end
		end ;
			

end
