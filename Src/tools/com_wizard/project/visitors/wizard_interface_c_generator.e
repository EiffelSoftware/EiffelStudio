indexing
	description: "Interface c generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_INTERFACE_C_GENERATOR
	
inherit
	WIZARD_CPP_WRITER_GENERATOR

	WIZARD_GUID_GENERATOR
		export 
			{NONE} all
		end

	ECOM_FUNC_KIND
		export 
			{NONE} all
		end

feature -- Access

	generate (a_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate c writer.
		local
			l_func_generator: WIZARD_CPP_VIRTUAL_FUNCTION_GENERATOR
			l_header_file: STRING
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
			l_functions: SORTED_TWO_WAY_LIST [WIZARD_FUNCTION_DESCRIPTOR]
			l_function: WIZARD_FUNCTION_DESCRIPTOR
			l_disp_functions: LIST [WIZARD_FUNCTION_DESCRIPTOR]
			l_properties: LIST [WIZARD_PROPERTY_DESCRIPTOR]
		do
			create cpp_class_writer.make
			cpp_class_writer.set_abstract
			create l_func_generator

			cpp_class_writer.set_name (a_descriptor.c_type_name)
			cpp_class_writer.set_namespace (a_descriptor.namespace)
			cpp_class_writer.set_header (a_descriptor.description)
			cpp_class_writer.set_declaration_header_file_name (a_descriptor.c_declaration_header_file_name)
			cpp_class_writer.set_definition_header_file_name (a_descriptor.c_definition_header_file_name)
			cpp_class_writer.add_other_source (iid_definition (a_descriptor.name, a_descriptor.guid))

			l_interface := a_descriptor.inherited_interface
			if l_interface /= Void then
				cpp_class_writer.add_parent (l_interface.c_type_name, l_interface.namespace, Public)
				if l_interface.c_definition_header_file_name /= Void and then not l_interface.c_definition_header_file_name.is_empty then
					cpp_class_writer.add_import (l_interface.c_definition_header_file_name)
				end
			end

			l_functions := a_descriptor.vtable_functions
			if l_functions /= Void and then not l_functions.is_empty then
				l_functions.sort
				from
					l_functions.start
				until
					l_functions.after
				loop
					l_function := l_functions.item
					if not l_function.is_renaming_clause then
						if l_function.func_kind = func_dispatch then
							l_func_generator.generate_dual (l_function)
						else
							l_func_generator.generate (l_function)
						end
						cpp_class_writer.add_function (l_func_generator.ccom_feature_writer, Public)
						add_type_definitions_and_include_files (l_func_generator)
					end
					l_functions.forth
				end
			end

			l_disp_functions := a_descriptor.dispatch_functions
			if l_disp_functions /= Void and then not l_disp_functions.is_empty then
				from
					l_disp_functions.start
				until
					l_disp_functions.off
				loop
					l_func_generator.generate_dual (l_disp_functions.item)
					add_type_definitions_and_include_files (l_func_generator)
					l_disp_functions.forth
				end
			end
			
			l_properties := a_descriptor.properties
			if l_properties /= Void and then not l_properties.is_empty then
				from
					l_properties.start
				until
					l_properties.off
				loop
					l_header_file := l_properties.item.data_type.visitor.c_definition_header_file_name
					if l_header_file /= Void and then not l_header_file.is_empty then
						add_include_file (l_header_file)
					end
					l_properties.forth
				end
			end

			Shared_file_name_factory.create_file_name (Current, cpp_class_writer)
			cpp_class_writer.save_declaration_header_file (Shared_file_name_factory.last_created_declaration_header_file_name)
			cpp_class_writer.save_definition_header_file (Shared_file_name_factory.last_created_header_file_name)
			cpp_class_writer := Void
		end

feature {NONE} -- Implementation

	add_type_definitions_and_include_files (func_generator: WIZARD_CPP_VIRTUAL_FUNCTION_GENERATOR) is
			-- Add neccessary type definitions and include files.
		require
			non_void_function_generator: func_generator /= Void
		local
			l_header_files, l_declarations: LIST [STRING]
			l_header_file, l_declaration: STRING
		do
			l_header_files := func_generator.c_header_files
			if l_header_files /= Void then
				from
					l_header_files.start
				until
					l_header_files.after
				loop
					l_header_file := l_header_files.item
					if l_header_file /= Void and then not l_header_file.is_empty then
						add_include_file (l_header_file)
					end
					l_header_files.forth
				end
			end

			l_declarations := func_generator.forward_declarations
			if l_declarations /= Void then
				from
					l_declarations.start
				until
					l_declarations.after
				loop
					l_declaration := l_declarations.item
					if l_declaration /= Void and then not l_declaration.is_empty then
						if cpp_class_writer.others.occurrences (l_declaration) = 0 then
							cpp_class_writer.add_other (l_declaration)
						end
					end
					l_declarations.forth
				end
			end
		end
	
	add_include_file (a_file: STRING) is
			-- Add include file.
		require
			non_void_file: a_file /= Void
			valid_file: not a_file.is_empty
		do
			if not cpp_class_writer.import_files.has (a_file) then
				cpp_class_writer.add_import (a_file)
			end
		ensure
			added: cpp_class_writer.import_files.has (a_file)
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
end -- class WIZARD_INTERFACE_C_GENERATOR

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

