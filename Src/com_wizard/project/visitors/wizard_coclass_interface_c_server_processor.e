indexing
	description: "Processing interfaces for C client coclass."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_INTERFACE_C_SERVER_PROCESSOR

inherit
	WIZARD_COCLASS_INTERFACE_C_PROCESSOR

create
	make

feature -- Basic operations

	generate_interface_features (a_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate interface features.
		local
			l_generator: WIZARD_COMPONENT_INTERFACE_C_SERVER_GENERATOR
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

				create l_generator.make (coclass, a_interface, coclass_generator.cpp_class_writer)
				l_generator.generate_functions_and_properties (a_interface)
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

