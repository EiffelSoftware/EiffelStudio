indexing
	description: "Component"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_DESCRIPTOR

inherit
	WIZARD_TYPE_DESCRIPTOR

feature -- Access

	type_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			-- Type library descriptor

feature -- Element Change

	set_type_library (a_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR) is
			-- Set `type_library_descriptor' with `a_descriptor'.
		require
			non_void_descriptor: a_descriptor /= Void
		do
			type_library_descriptor := a_descriptor
		ensure
			valid_type_library: type_library_descriptor = a_descriptor
		end

end -- class WIZARD_COMPONENT_DESCRIPTOR

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
