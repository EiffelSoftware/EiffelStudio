indexing
	description: "[
			Exception for assignment of void value to expanded entity
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	VOID_ASSIGNED_TO_EXPANDED

inherit
	LANGUAGE_EXCEPTION

feature -- Access

	frozen code: INTEGER is
			-- Exception code
		once
			Result := {EXCEP_CONST}.void_assigned_to_expanded
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING is "Void assigned to expanded."

end
