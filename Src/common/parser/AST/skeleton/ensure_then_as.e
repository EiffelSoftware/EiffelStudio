class ENSURE_THEN_AS

inherit

	ENSURE_AS
		redefine
			is_then
		end

feature

	is_then: BOOLEAN is
			-- Is the assertion list an "ensure then" part ?
		do
			Result := True;
		end;

end
