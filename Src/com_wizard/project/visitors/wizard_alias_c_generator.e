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
			l_definition.append ("%R%N{%R%N%Ttypedef ")
			l_definition.append (l_visitor.c_type)
			l_definition.append (" ")
			l_definition.append (alias_descriptor.c_type_name)
			l_definition.append (l_visitor.c_post_type)
			l_definition.append (";%R%N}")
			c_writer.add_other (l_definition)
			c_writer := Void
		end

end -- class WIZARD_ALIAS_C_GENERATOR

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

