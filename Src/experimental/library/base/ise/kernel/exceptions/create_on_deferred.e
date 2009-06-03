note
	description: "[
			Exception raised when creating deferred classes
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_ON_DEFERRED

inherit
	EIFFELSTUDIO_SPECIFIC_LANGUAGE_EXCEPTION

feature -- Access

	frozen code: INTEGER
			-- Exception code
		do
			Result := {EXCEP_CONST}.create_on_deferred
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING = "Create on deferred."

end
