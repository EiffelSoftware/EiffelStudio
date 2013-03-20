note
	description: "[
		Exception for feature applied to void reference
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	VOID_TARGET

inherit
	LANGUAGE_EXCEPTION

feature -- Access

	frozen code: INTEGER
			-- Exception code
		do
			Result := {EXCEP_CONST}.void_call_target
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING = "Feature call on void target."

end
