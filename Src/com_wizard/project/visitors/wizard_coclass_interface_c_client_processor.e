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

	generate_interface_features (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate interface features.
		local
			a_name, a_variable_name, a_variable_type: STRING
			data_member: WIZARD_WRITER_C_MEMBER
			interface_generator: WIZARD_COMPONENT_INTERFACE_C_CLIENT_GENERATOR
		do
			-- Add  import header files
			coclass_generator.cpp_class_writer.add_import (an_interface.c_header_file_name)
			coclass_generator.cpp_class_writer.add_other_source (iid_definition (an_interface.name, an_interface.guid))

			create data_member.make
			data_member.set_comment (Interface_pointer_comment)

			create a_variable_name.make (100)
			a_variable_name.append (Interface_variable_prepend)
			a_variable_name.append (an_interface.c_type_name)
			data_member.set_name (a_variable_name)

			-- Variable type
			create a_variable_type.make (100)
			if an_interface.namespace /= Void and then not an_interface.namespace.empty then
				a_variable_type.append (an_interface.namespace)
				a_variable_type.append ("::")
			end
			a_variable_type.append (an_interface.c_type_name)
			a_variable_type.append (Space)
			a_variable_type.append (Asterisk)
			data_member.set_result_type (a_variable_type)

			coclass_generator.cpp_class_writer.add_member (data_member, Private)

			-- Find all features and properties
			a_name := an_interface.c_type_name
			coclass_generator.interface_names.extend (a_name)

			if 
				an_interface.dispinterface or 
				an_interface.dual 
			then
				dispatch_interface := True
			end
			create interface_generator.make (coclass, an_interface, coclass_generator.cpp_class_writer)
			interface_generator.generate_functions_and_properties (an_interface)
		end

	generate_source_interface_features (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate source interface features.
		local
			c_server_visitor: WIZARD_C_SERVER_VISITOR
			source_generator: WIZARD_SOURCE_INTERFACE_C_CLIENT_GENERATOR
		do
			remove_from_system_interfaces (an_interface.implemented_interface)
			create c_server_visitor
			c_server_visitor.visit (an_interface.implemented_interface)
			create source_generator.generate (an_interface, coclass_generator.cpp_class_writer)
		end

end -- class WIZARD_COCLASS_INTERFACE_C_CLIENT_PROCESSOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
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
