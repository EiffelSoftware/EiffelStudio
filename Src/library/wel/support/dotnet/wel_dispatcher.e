note
	description: "Receives and dispatch the Windows messages to the Eiffel objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DISPATCHER

inherit
	WEL_ABSTRACT_DISPATCHER
		redefine
			make
		end

	DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize the C variables
		do
			Precursor
			create window_delegate.make (Current, $window_procedure)
			create dialog_delegate.make (Current, $dialog_procedure)
			cwel_set_window_procedure_address (window_delegate)
			cwel_set_dialog_procedure_address (dialog_delegate)
			dispatcher_object := {GC_HANDLE}.alloc (Current)
			cwel_set_dispatcher_object ({GC_HANDLE}.to_pointer (dispatcher_object))
		end

feature {NONE} -- Implementation

	dispatcher_object: GC_HANDLE
			-- Handle to Current.
			
	window_delegate, dialog_delegate: detachable WEL_DISPATCHER_DELEGATE note option: stable attribute end
			-- Delegate for callbacks.
			
	dispose
			-- Wean `Current'
		local
			null: POINTER
		do
			dispatcher_object.free
			cwel_set_dispatcher_object (null)
		end

feature {NONE} -- Externals

	cwel_set_window_procedure_address (address: like window_delegate)
		external
			"C [macro %"disptchr.h%"] (EIF_POINTER)"
		end

	cwel_set_dialog_procedure_address (address: like dialog_delegate)
		external
			"C [macro %"disptchr.h%"] (EIF_POINTER)"
		end

	cwel_set_dispatcher_object (dispatcher: POINTER)
		external
			"C [macro %"disptchr.h%"]"
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


end -- class WEL_DISPATCHER

