indexing
	description: "Processing interfaces for C client coclass."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_INTERFACE_C_CLIENT_PROCESSOR

inherit
	WIZARD_COCLASS_INTERFACE_C_PROCESSOR

create
	make

feature -- Basic operations

	generate_interface_features (a_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate interface features.
		local
			l_name, l_variable_name, l_type: STRING
			l_member: WIZARD_WRITER_C_MEMBER
			l_generator: WIZARD_COMPONENT_INTERFACE_C_CLIENT_GENERATOR
			l_writer: WIZARD_WRITER_CPP_CLASS
		do
			if a_interface.is_implementing_coclass (coclass) and
					not a_interface.is_iunknown and not a_interface.is_idispatch then
				l_writer := coclass_generator.cpp_class_writer
				l_writer.add_import (a_interface.c_definition_header_file_name)
				l_writer.add_other_source (iid_definition (a_interface.name, a_interface.guid))

				create l_member.make
				l_member.set_comment (Interface_pointer_comment)

				create l_variable_name.make (100)
				l_variable_name.append (Interface_variable_prepend)
				l_variable_name.append (a_interface.c_type_name)
				l_member.set_name (l_variable_name)

				create l_type.make (100)
				if a_interface.namespace /= Void and then not a_interface.namespace.is_empty then
					l_type.append (a_interface.namespace)
					l_type.append ("::")
				end
				l_type.append (a_interface.c_type_name)
				l_type.append (Space)
				l_type.append (Asterisk)
				l_member.set_result_type (l_type)

				l_writer.add_member (l_member, Private)

				l_name := a_interface.c_type_name
				coclass_generator.interface_names.extend (l_name)

				dispatch_interface := a_interface.dispinterface or a_interface.dual

				create l_generator.make (coclass, a_interface, l_writer)
				l_generator.generate_functions_and_properties (a_interface)
			end
		end

	generate_source_interface_features (a_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate source interface features.
		local
			c_server_visitor: WIZARD_C_SERVER_VISITOR
			source_generator: WIZARD_SOURCE_INTERFACE_C_CLIENT_GENERATOR
		do
			create c_server_visitor
			c_server_visitor.visit (a_interface.implemented_interface)
			create source_generator.generate (a_interface, coclass_generator.cpp_class_writer)
		end

end -- class WIZARD_COCLASS_INTERFACE_C_CLIENT_PROCESSOR

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

