indexing
	description: "Receives and dispatch the Windows messages to the Eiffel objects."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DISPATCHER

inherit
	WEL_ABSTRACT_DISPATCHER

	DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize the C variables
		do
			create window_delegate.make (Current, $window_procedure)
			create dialog_delegate.make (Current, $dialog_procedure)
			cwel_set_window_procedure_address (window_delegate)
			cwel_set_dialog_procedure_address (dialog_delegate)
			dispatcher_object := feature {GC_HANDLE}.alloc (Current)
			cwel_set_dispatcher_object (feature {GC_HANDLE}.to_pointer (dispatcher_object))
		end

feature {NONE} -- Implementation

	dispatcher_object: GC_HANDLE
			-- Handle to Current.
			
	window_delegate, dialog_delegate: WEL_DISPATCHER_DELEGATE
			-- Delegate for callbacks.
			
	dispose is
			-- Wean `Current'
		local
			null: POINTER
		do
			dispatcher_object.free
			cwel_set_dispatcher_object (null)
		end

feature {NONE} -- Externals

	cwel_set_window_procedure_address (address: WEL_DISPATCHER_DELEGATE) is
		external
			"C [macro %"disptchr.h%"] (EIF_POINTER)"
		end

	cwel_set_dialog_procedure_address (address: WEL_DISPATCHER_DELEGATE) is
		external
			"C [macro %"disptchr.h%"] (EIF_POINTER)"
		end

	cwel_set_dispatcher_object (dispatcher: POINTER) is
		external
			"C [macro %"disptchr.h%"]"
		end

end -- class WEL_DISPATCHER

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

