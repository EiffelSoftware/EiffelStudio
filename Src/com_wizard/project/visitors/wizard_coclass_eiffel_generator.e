indexing
	description: "Coclass eiffel generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COCLASS_EIFFEL_GENERATOR 

inherit
	WIZARD_EIFFEL_WRITER_GENERATOR

	WIZARD_COMPONENT_EIFFEL_GENERATOR

feature -- Basic Operations

	generate (a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate eiffel class for coclass.
		do
			create eiffel_writer.make
			coclass_descriptor := a_coclass

			-- Set class name and description
			eiffel_writer.set_class_name (a_coclass.eiffel_class_name)
			eiffel_writer.set_description (a_coclass.description)

			process_interfaces (a_coclass)

			set_default_ancestors (eiffel_writer)
			add_creation
		end

	process_interfaces (a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Process coclass interfaces.
		deferred
		end

feature {NONE} -- Implementation

	coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR
			-- Coclass descriptor


end -- class WIZARD_COCLASS_EIFFEL_GENERATOR

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

