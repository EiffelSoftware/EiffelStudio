indexing
	description: "Processing interfaces for Eiffel client coclass."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_INTERFACE_EIFFEL_CLIENT_PROCESSOR

inherit
	WIZARD_COCLASS_INTERFACE_EIFFEL_PROCESSOR 

	WIZARD_SHARED_GENERATORS
		export
			{NONE} all
		end

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
		do
			Eiffel_client_generator.initialize (coclass, a_interface, eiffel_writer, a_inherit_clause)
			Eiffel_client_generator.generate_functions_and_properties (a_interface)
		end

end -- class WIZARD_COCLASS_INTERFACE_EIFFEL_CLIENT_PROCESSOR

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

