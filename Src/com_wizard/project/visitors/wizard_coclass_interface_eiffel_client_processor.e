indexing
	description: "Processing interfaces for Eiffel client coclass."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_INTERFACE_EIFFEL_CLIENT_PROCESSOR

inherit
	WIZARD_COCLASS_INTERFACE_EIFFEL_PROCESSOR 

create
	make

feature -- Basic operations

	generate_source_interface_features (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate source interface features.
		local
			eiffel_server_visitor: WIZARD_EIFFEL_SERVER_VISITOR
			source_generator: WIZARD_SOURCE_INTERFACE_EIFFEL_CLIENT_GENERATOR
		do
			create eiffel_server_visitor
			eiffel_server_visitor.visit (an_interface.implemented_interface)

			create source_generator.generate (an_interface, coclass, eiffel_writer)
		end

	generate_functions_and_properties (an_interface: WIZARD_INTERFACE_DESCRIPTOR;
				an_inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE) is
			-- Generate functions and properties for interface.
		local
			interface_generator: WIZARD_COMPONENT_INTERFACE_EIFFEL_CLIENT_GENERATOR
		do
			create interface_generator.make (coclass, an_interface, eiffel_writer, an_inherit_clause)
			interface_generator.generate_functions_and_properties (an_interface)
		end

end -- class WIZARD_COCLASS_INTERFACE_EIFFEL_CLIENT_PROCESSOR

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
