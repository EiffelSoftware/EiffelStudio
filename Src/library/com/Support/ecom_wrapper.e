indexing
	description: "Wrapper of C structures and Interfaces"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECOM_WRAPPER

inherit
	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end

	ECOM_EXCEPTION_CODES
		export
			{NONE} all
		end

	ANY

feature -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Initialize
		require
			valid_pointer: a_pointer /= default_pointer
		do
			initializer := create_wrapper (a_pointer)
			item := a_pointer
		ensure
			wrapper_exist: initializer /= default_pointer and then
					exists
			valid_item: item = a_pointer
		end

feature -- Access

	item: POINTER
			-- Pointer to COM structure

	exists: BOOLEAN is
			-- Is wrapped structure initialized?
		do
			Result := item /= default_pointer
		end

feature {NONE} -- Implementation

	initializer: POINTER
			-- Pointer to C++ wrapper

	dispose is
			-- Delete C++ wrapper
		do
			delete_wrapper
		end

	create_wrapper (a_pointer: POINTER): POINTER is
			-- Create C++ wrapper
		require 
			valid_pointer: a_pointer /= default_pointer
		deferred
		end

	delete_wrapper is
			-- Delete C++ wrapper
		deferred
		end

invariant
	wrapper_invariant: initializer /= default_pointer and then
					exists

end -- class ECOM_WRAPPER

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

