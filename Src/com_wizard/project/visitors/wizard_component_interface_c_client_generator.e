indexing
	description: "Processing interface for C client component."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COMPONENT_INTERFACE_C_CLIENT_GENERATOR

inherit
	WIZARD_COMPONENT_INTERFACE_C_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER
		rename
			Component as Name_mapper_component,
			Interface as Name_mapper_interface
		export
			{NONE} all
		undefine
			default_create
		end

feature -- Basic operations

	process_property (a_property: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Process property.
		local
			l_generator: WIZARD_CPP_CLIENT_PROPERTY_GENERATOR
			l_interface_name: STRING
		do
			l_interface_name := interface.name
			create l_generator.generate (component, a_property, l_interface_name, variable_name (l_interface_name), interface.lcid)
			cpp_class_writer.add_function (l_generator.c_access_feature, Public)

			if not a_property.is_read_only then
				cpp_class_writer.add_function (l_generator.c_setting_feature, Public)
			end
		end

	process_function (a_function: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Process function.
		local
			l_generator: WIZARD_CPP_VTABLE_CLIENT_FUNCTION_GENERATOR
			l_disp_generator: WIZARD_CPP_DISPATCH_CLIENT_FUNCTION_GENERATOR
			l_header_files: LIST [STRING]
			l_interface_name: STRING
		do
			if not a_function.is_renaming_clause then
				l_interface_name := interface.name
				if a_function.func_kind = func_dispatch and not a_function.dual then
					create l_disp_generator
					l_disp_generator.generate (component, l_interface_name, variable_name (l_interface_name), interface.guid.to_string, interface.lcid, a_function)
					cpp_class_writer.add_function (l_disp_generator.ccom_feature_writer, Public)
				else
					create l_generator
					l_generator.generate (component, l_interface_name, variable_name (l_interface_name), a_function)
					cpp_class_writer.add_function (l_generator.ccom_feature_writer, Public)
					l_header_files := l_generator.c_header_files
					from
						l_header_files.start
					until
						l_header_files.after
					loop
						if not cpp_class_writer.import_files.has (l_header_files.item) then
							cpp_class_writer.add_import (l_header_files.item)
						end
						l_header_files.forth
					end
				end
			end
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
end -- class WIZARD_COMPONENT_INTERFACE_C_CLIENT_GENERATOR

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

