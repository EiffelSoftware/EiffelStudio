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

	generate_source_interface_features (a_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate source interface features.
		local
			l_visitor: WIZARD_EIFFEL_SERVER_VISITOR
			l_generator: WIZARD_SOURCE_INTERFACE_EIFFEL_CLIENT_GENERATOR
		do
			create l_visitor
			l_visitor.visit (a_interface.implemented_interface)
			create l_generator.generate (a_interface, coclass, eiffel_writer)
		end

	generate_functions_and_properties (a_interface: WIZARD_INTERFACE_DESCRIPTOR; a_inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE) is
			-- Generate functions and properties for interface.
		local
			l_generator: WIZARD_COMPONENT_INTERFACE_EIFFEL_CLIENT_GENERATOR
		do
			create l_generator.make (coclass, a_interface, eiffel_writer, a_inherit_clause)
			l_generator.generate_functions_and_properties (a_interface)
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
