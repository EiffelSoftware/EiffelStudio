indexing
	description: "Processing interfaces for Eiffel server coclass."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_INTERFACE_EIFFEL_SERVER_PROCESSOR

inherit
	WIZARD_COCLASS_INTERFACE_EIFFEL_PROCESSOR 

create
	make

feature -- Basic operations

	generate_source_interface_features (an_interface: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate source interface features.
		local
			eiffel_client_visitor: WIZARD_EIFFEL_CLIENT_VISITOR
			source_generator: WIZARD_SOURCE_INTERFACE_EIFFEL_SERVER_GENERATOR
		do
			create eiffel_client_visitor
			eiffel_client_visitor.visit (an_interface.implemented_interface)
			create source_generator.generate (an_interface, coclass, eiffel_writer)
		end

	generate_functions_and_properties (an_interface: WIZARD_INTERFACE_DESCRIPTOR;
				an_inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE) is
			-- Generate functions and properties for interface.
		local
			interface_generator: WIZARD_COCLASS_INTERFACE_EIFFEL_SERVER_GENERATOR
		do
			create interface_generator.make (coclass, an_interface, eiffel_writer, an_inherit_clause)
			interface_generator.generate_functions_and_properties (an_interface)
		end

end -- class WIZARD_COCLASS_INTERFACE_EIFFEL_SERVER_PROCESSOR

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

