indexing
	description: "Component C server generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_C_SERVER_GENERATOR

inherit
	WIZARD_COMPONENT_C_GENERATOR

	WIZARD_CPP_WRITER_GENERATOR

	ECOM_FUNC_KIND
		export
			{NONE} all
		end

	ECOM_VAR_FLAGS
		export 
			{NONE} all
		end

feature -- Access

	dispatch_interface: BOOLEAN
			-- Is coclass contained dispatch interface?

end -- class WIZARD_COMPONENT_C_SERVER_GENERATOR

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
