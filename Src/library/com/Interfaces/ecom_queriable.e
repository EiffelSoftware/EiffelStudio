indexing
	description: "COM Queriable"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECOM_QUERIABLE

inherit
	MEMORY
		export
			{NONE} all
		redefine 
			dispose
		end

feature  {NONE} -- Initialization

	make_from_other (other: ECOM_QUERIABLE) is
			-- Make from other Queriable.
		require
			non_void_other: other /= Void
			valid_other: other.item /= default_pointer
		do
			make_from_pointer (other.item)
		ensure
			valid_initializer: initializer /= default_pointer
			exists: exists
		end

	make_from_pointer (a_pointer: POINTER) is
			-- Make from interface pointer.
		require
			non_default_pointer: a_pointer /= default_pointer
		deferred
		ensure
			valid_initializer: initializer /= default_pointer
			exists: exists
		end

feature -- Access

	exists: BOOLEAN is
			-- Is wrapped structure initialized?
		do
			Result := item /= default_pointer
		end;

	item: POINTER;
			-- Pointer to COM object wrapper.

feature {NONE} -- Implementation

	initializer: POINTER;
			-- Pointer to C++ wrapper

	dispose is
			-- Delete C++ wrapper
		do
			delete_wrapper
		end;

	delete_wrapper is
			-- Delete C++ wrapper
		deferred
		end;

invariant
	queriable_invariant: initializer /= default_pointer and then exists;

end -- class ECOM_QUERIABLE

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
