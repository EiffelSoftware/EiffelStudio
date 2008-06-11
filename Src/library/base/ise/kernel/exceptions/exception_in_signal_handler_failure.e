indexing
	description: "[
		Exception raised in signal handler
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	EXCEPTION_IN_SIGNAL_HANDLER_FAILURE

inherit
	OBSOLETE_EXCEPTION

feature -- Access

	frozen code: INTEGER is
			-- Exception code
		do
			Result := {EXCEP_CONST}.exception_in_signal_handler
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING is "Exception in signal handler."

end
