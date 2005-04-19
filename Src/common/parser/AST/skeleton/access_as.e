indexing
	description: "Abstract description of a non-nested call."
	date: "$Date$"
	revision: "$Revision$"

deferred class ACCESS_AS

inherit
	CALL_AS

feature -- Properties

	access_name: STRING is
		deferred
		end
		
	parameters: EIFFEL_LIST [EXPR_AS] is
			-- List of parameters if any
		deferred
		end

end -- class ACCESS_AS
