indexing
	description: "Inherited interface descriptor."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INHERITED_INTERFACE_DESCRIPTOR

create
	make

feature -- Initialization

	make (a_library: WIZARD_TYPE_LIBRARY_DESCRIPTOR; an_index: INTEGER) is
			-- Initialization.
		require
			non_void_library: a_library /= Void
			valid_index: an_index > 0
		do
			library := a_library
			index := an_index
		ensure
			non_void_library: library /= Void
			valid_index: index > 0
		end

feature -- Access

	library: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			-- Type library.

	index: INTEGER
			-- Index in type library.

invariant
	non_void_library: library /= Void
	valid_index: index > 0

end -- class WIZARD_INHERITED_INTERFACE_DESCRIPTOR

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

