class REQUIRE_ELSE_AS

inherit

	REQUIRE_AS
		redefine
			is_else
		end

feature

	is_else: BOOLEAN is
			-- Is the assertion list a require else ?
		do
			Result := true;
		end;

end -- class REQUIRE_ELSE_AS
