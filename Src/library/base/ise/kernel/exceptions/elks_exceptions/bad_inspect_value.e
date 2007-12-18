indexing
	description: "[
		Exception raised by inspect value which is not one
		of the inspect constants, if there is no Else_part.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	BAD_INSPECT_VALUE

inherit
	LANGUAGE_EXCEPTION

feature -- Access

	frozen code: INTEGER is
			-- Exception code
		once
			Result := {EXCEP_CONST}.incorrect_inspect_value
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING is "Unmatched inspect value."

end
