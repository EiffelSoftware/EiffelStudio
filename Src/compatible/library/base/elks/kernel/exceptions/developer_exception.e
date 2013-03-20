note
	description: "[
		Ancestor of all developer exceptions
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	DEVELOPER_EXCEPTION

inherit
	EXCEPTION
		redefine
			code,
			internal_meaning
		end

feature -- Access

	frozen code: INTEGER
			-- Exception code
		do
			Result := {EXCEP_CONST}.developer_exception
		end

feature {NONE} -- Access

	internal_meaning: STRING
		once
			Result := "Developer exception."
		end

end
