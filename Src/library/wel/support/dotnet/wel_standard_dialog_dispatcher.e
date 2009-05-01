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
		local
			l_dialog_delegate: like dialog_delegate
		do
			create l_dialog_delegate.make (Current, $standard_dialog_procedure)
			cwel_set_standard_dialog_procedure_address (l_dialog_delegate)
			dialog_delegate := l_dialog_delegate
		end

	end_activate
			-- Uninitialize the C variables.
		do
			dialog_delegate := Void
			cwel_set_standard_dialog_procedure_address (Void)
		end

feature {NONE} -- Implementation

	standard_dialog_procedure (hdlg: POINTER; msg: INTEGER_32; wparam, lparam: POINTER): POINTER
		deferred
		end

feature {NONE} -- Externals

	dialog_delegate: detachable WEL_DISPATCHER_DELEGATE
			-- Delegate for callbacks.

	cwel_set_standard_dialog_procedure_address (address: like dialog_delegate)
		external
			"C [macro %"disptchr.h%"] (EIF_POINTER)"
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
