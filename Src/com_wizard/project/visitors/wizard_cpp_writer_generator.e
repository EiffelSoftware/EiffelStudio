indexing
	description: "C type generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_CPP_WRITER_GENERATOR

inherit
	WIZARD_TYPE_GENERATOR

	WIZARD_WRITER_CPP_EXPORT_STATUS
		export
			{NONE} all
		end


feature -- Access

	cpp_class_writer: WIZARD_WRITER_CPP_CLASS
			-- Cpp implementation writer


end -- class WIZARD_C_WRITER_GENERATOR

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
