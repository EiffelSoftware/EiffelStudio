indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_INPUT_CONTEXT

feature -- Access

feature -- Externals

	cwel_get_imm_context (window: POINTER): POINTER is
			-- (export status {NONE})
		external
			"C macro signature (HWND): EIF_POINTER use <windows.h>"
		alias
			"ImmGetContext"
		end

end -- class WEL_INPUT_CONTEXT
