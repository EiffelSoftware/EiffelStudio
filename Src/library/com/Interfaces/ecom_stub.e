indexing
	description: "COM Stub."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECOM_STUB

inherit
	ECOM_INTERFACE

feature -- Access

	exists: BOOLEAN is
			-- Is stub initialized?
		do
			Result := item /= default_pointer
		end

	item: POINTER
			-- Pointer to COM object stub.

feature -- Basic operations

	set_item (an_item: POINTER) is
			-- Set `item' with `an_item'.
		do
			item := an_item
		ensure
			valid_item: item = an_item
		end

	create_item is
			-- Create COM stub.
		require
			not_exists: not exists
		deferred
		ensure
			exists: exists
		end

end -- class ECOM_STUB

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
