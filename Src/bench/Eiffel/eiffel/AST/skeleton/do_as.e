indexing
	description: "AST representation of a non-deferred routine.";
	date: "$Date$";
	revision: "$Revision$"

class DO_AS

inherit
	INTERNAL_AS

feature {NONE}

	begin_keyword: BASIC_TEXT is
			-- "do" keyword
		once
			Result := ti_Do_keyword
		end

end -- class DO_AS
