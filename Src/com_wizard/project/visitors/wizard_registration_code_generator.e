indexing
	description: "Objects that generate component registration code"
	status: " See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_REGISTRATION_CODE_GENERATOR

inherit
	WIZARD_TYPE_GENERATOR

feature  -- Initialization

	initialize is
			-- Initialize
		do
			c_writer := Void
		ensure
			void_writer: c_writer = Void
		end

feature -- Access

	c_writer: WIZARD_WRITER_C_FILE

feature -- Basic operations

	generate (a_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate class object.
		local
			tmp_string: STRING
			member_writer: WIZARD_WRITER_C_MEMBER
		do
			create c_writer.make

			-- Import/include header file
			tmp_string := clone (a_descriptor.c_type_name)
			tmp_string.append (Factory)
			tmp_string.append (Header_file_extension)
			c_writer.add_import (tmp_string)
		end

feature {NONE} -- Implementation

end -- class WIZARD_REGISTRATION_CODE_GENERATOR

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