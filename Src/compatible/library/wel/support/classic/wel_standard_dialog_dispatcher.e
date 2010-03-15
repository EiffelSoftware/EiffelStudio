note
	description: "[
		Wrapper to perform dispatch for standard dialogs. It is intended to be used through inheritance.
		Descendants of this class should wrap the call to the Window API to show the dialog with a call
		to `begin_activate' and `end_activate'.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_STANDARD_DIALOG_DISPATCHER

feature {NONE} -- Initialization

	begin_activate
			-- Initialize the C variables.
		do
			cwel_set_standard_dialog_procedure_address ($standard_dialog_procedure)
			cwel_set_stddlg_dispatcher_object (Current)
		end

	end_activate
			-- Uninitialize the C variables.
		local
			l_null: POINTER
		do
			cwel_set_standard_dialog_procedure_address (l_null)
			cwel_release_stddlg_dispatcher_object
		end

feature {NONE} -- Implementation

	standard_dialog_procedure (hdlg: POINTER; msg: INTEGER_32; wparam, lparam: POINTER): POINTER
		deferred
		end

feature {NONE} -- Externals

	cwel_set_standard_dialog_procedure_address (address: POINTER)
		external
			"C [macro %"disptchr.h%"]"
		end

	cwel_set_stddlg_dispatcher_object (dispatcher: like Current)
		external
			"C macro signature (EIF_OBJECT) use %"disptchr.h%""
		end

	cwel_release_stddlg_dispatcher_object
		external
			"C [macro %"disptchr.h%"]"
		end

	wel_standard_dialog_procedure: POINTER
			-- Address of the C routine wrapping `standard_dialog_procedure'.
		external
			"C inline use %"disptchr.h%""
		alias
			"return (EIF_POINTER) cwel_standard_dialog_procedure;"
		end


note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
