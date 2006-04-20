indexing
	description: "Processing interfaces for C client coclass."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_INTERFACE_C_SERVER_PROCESSOR

inherit
	WIZARD_COCLASS_INTERFACE_C_PROCESSOR

	WIZARD_SHARED_GENERATORS
		export
			{NONE} all
		end

create
	make

feature -- Basic operations

	generate_interface_features (a_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate interface features.
		do
			if not a_interface.is_iunknown and not a_interface.is_idispatch then
				coclass_generator.cpp_class_writer.add_other_source (iid_definition (a_interface.name, a_interface.guid))
			end
			if a_interface.is_implementing_coclass (coclass) then
				coclass_generator.cpp_class_writer.add_parent (a_interface.c_type_name, a_interface.namespace, Public)
				
				if not a_interface.c_definition_header_file_name.is_empty then
					coclass_generator.cpp_class_writer.add_import (a_interface.c_definition_header_file_name)
				end

				coclass_generator.interface_names.extend (a_interface.c_type_name)

				if a_interface.dispinterface or a_interface.dual or a_interface.is_idispatch_heir then
					coclass_generator.dispinterface_names.extend (a_interface.c_type_name)
					dispatch_interface := True
				end

				C_server_generator.initialize (coclass, a_interface, coclass_generator.cpp_class_writer)
				C_server_generator.generate_functions_and_properties (a_interface)
			end
		end

	generate_source_interface_features (a_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate source interface features.
		local
			c_client_visitor: WIZARD_C_CLIENT_VISITOR
			source_generator: WIZARD_SOURCE_INTERFACE_C_SERVER_GENERATOR
		do
			create c_client_visitor
			c_client_visitor.visit (a_interface.implemented_interface)
			create source_generator.generate (a_interface, coclass_generator.cpp_class_writer)
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
end -- class WIZARD_COCLASS_INTERFACE_C_SERVER_PROCESSOR

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

