indexing
	description: "Generator of generated run-time globals."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_GENERATED_RT_GLOBALS_GENERATOR

inherit
	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SHARED_MAPPER_HELPERS
		export
			{NONE} all
		end

create
	generate 

feature -- Basic operations

	generate is
			-- Generate Generated Globals header file.
		local
			cpp_writer: WIZARD_WRITER_C_FILE
			l_mapper: WIZARD_WRITER_MAPPER_CLASS
			l_other, l_class_name, l_variable_name: STRING
		do
			create cpp_writer.make
			cpp_writer.set_header_file_name (Ecom_generated_rt_globals_header_file_name)
			cpp_writer.set_header ("Global variables used in generated code.")
			cpp_writer.add_import ("ecom_rt_globals.h")
			
			from
				Generated_ec_mappers.start
			until
				Generated_ec_mappers.after				
			loop
				cpp_writer.add_import (Generated_ec_mappers.item.definition_header_file_name)
				Generated_ec_mappers.forth
			end
			
			from
				Generated_ce_mappers.start
			until
				Generated_ce_mappers.after				
			loop
				cpp_writer.add_import (Generated_ce_mappers.item.definition_header_file_name)
				Generated_ce_mappers.forth
			end
			
			from
				Generated_ec_mappers.start
			until
				Generated_ec_mappers.after
			loop
				l_mapper := Generated_ec_mappers.item
				l_class_name := l_mapper.name
				l_variable_name := l_mapper.variable_name
				create l_other.make (7 + l_class_name.count + 1 + l_variable_name.count + 1)
				l_other.append ("extern ")
				l_other.append (l_class_name)
				l_other.append_character (' ')
				l_other.append (l_variable_name)
				l_other.append_character (';')
				cpp_writer.add_other (l_other)
				Generated_ec_mappers.forth
			end

			from
				Generated_ce_mappers.start
			until
				Generated_ce_mappers.after
			loop
				l_mapper := Generated_ce_mappers.item
				l_class_name := l_mapper.name
				l_variable_name := l_mapper.variable_name
				create l_other.make (7 + l_class_name.count + 1 + l_variable_name.count + 1)
				l_other.append ("extern ")
				l_other.append (l_class_name)
				l_other.append_character (' ')
				l_other.append (l_variable_name)
				l_other.append_character (';')
				cpp_writer.add_other (l_other)
				Generated_ce_mappers.forth
			end

			shared_file_name_factory.create_generated_mapper_file_name (cpp_writer)
			cpp_writer.save_header_file (shared_file_name_factory.last_created_header_file_name)
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
end -- class WIZARD_GENERATED_RT_GLOBALS_GENERATOR

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

