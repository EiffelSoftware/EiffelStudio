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

	generate_interface_features (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate interface features.
		local
			interface_generator: WIZARD_COMPONENT_INTERFACE_C_SERVER_GENERATOR
		do
			-- Add parent and import header files
			coclass_generator.cpp_class_writer.add_parent (an_interface.c_type_name, 
					an_interface.namespace, Public)
			coclass_generator.cpp_class_writer.add_import (an_interface.c_header_file_name)
			coclass_generator.cpp_class_writer.add_other_source (iid_definition (an_interface.name, an_interface.guid))

			coclass_generator.interface_names.extend (an_interface.c_type_name)

			if an_interface.dispinterface or an_interface.dual then
				coclass_generator.dispinterface_names.extend (an_interface.c_type_name)
				dispatch_interface := True
			end

			create interface_generator.make (coclass, an_interface, coclass_generator.cpp_class_writer)
			interface_generator.generate_functions_and_properties (an_interface)
		end

	generate_source_interface_features (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate source interface features.
		do
		end

end -- class WIZARD_COCLASS_INTERFACE_C_SERVER_PROCESSOR

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
