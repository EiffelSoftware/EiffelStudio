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

	make (a_library: WIZARD_TYPE_LIBRARY_DESCRIPTOR; a_index: INTEGER) is
			-- Initialization.
		require
			non_void_library: a_library /= Void
			valid_index: a_index > 0
		do
			library := a_library
			index := a_index
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

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

