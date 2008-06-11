indexing
	description: "[
			Exception for retrieval error, 
			may be raised by `retrieved' in `IO_MEDIUM'.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	MISMATCH_FAILURE

inherit
	DATA_EXCEPTION

feature -- Access

	frozen code: INTEGER is
			-- Exception code
		do
			Result := {EXCEP_CONST}.retrieve_exception
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING is "Mismatch failed."

end
