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
			l_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR
			l_visitor: WIZARD_DATA_TYPE_VISITOR
			l_definition, l_name: STRING
		do
			c_writer := Alias_c_writer
			l_descriptor := alias_descriptor.type_descriptor
			l_visitor := l_descriptor.visitor
			l_name := l_visitor.c_definition_header_file_name
			if l_name /= Void and then not l_name.is_empty then
				c_writer.add_import (l_name)
			end
			create l_definition.make (100)
			l_definition.append ("namespace ")
			l_definition.append (alias_descriptor.namespace)
			l_definition.append ("%N{%N%Ttypedef ")
			l_definition.append (l_visitor.c_type)
			l_definition.append (" ")
			l_definition.append (alias_descriptor.c_type_name)
			l_definition.append (l_visitor.c_post_type)
			l_definition.append (";%N}")
			c_writer.add_other (l_definition)
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

