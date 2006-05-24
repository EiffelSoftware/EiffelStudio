indexing
	description: "Alias C generator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class WIZARD_ALIAS_C_GENERATOR


