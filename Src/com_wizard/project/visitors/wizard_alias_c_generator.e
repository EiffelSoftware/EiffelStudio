indexing
	description: "Alias C generator"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_ALIAS_C_GENERATOR

inherit
	WIZARD_TYPE_GENERATOR

feature -- Access

	c_writer: WIZARD_WRITER_C_FILE
			-- Writer of C file.

	generate (alias_descriptor: WIZARD_ALIAS_DESCRIPTOR) is
			-- Generate C alias.
		local
			a_data_type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR
			a_data_visitor: WIZARD_DATA_TYPE_VISITOR
			type_definition: STRING
			included_name: STRING
			header: STRING
		do
			c_writer := Alias_c_writer
			a_data_type_descriptor := alias_descriptor.type_descriptor

			a_data_visitor := a_data_type_descriptor.visitor

			included_name := a_data_visitor.c_header_file
			if not (included_name = Void or else included_name.empty) then
				c_writer.add_import (clone (included_name))
			end

			create type_definition.make (100)
			type_definition.append (Typedef)
			type_definition.append (Space)
			type_definition.append (a_data_visitor.c_type)
			type_definition.append (Space)
			type_definition.append (alias_descriptor.c_type_name)
			type_definition.append (a_data_visitor.c_post_type)
			type_definition.append (Semicolon)

			c_writer.add_other (type_definition)

			c_writer := Void
		end

end -- class WIZARD_ALIAS_C_GENERATOR

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

