indexing
	description: "Coclass eiffel server generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_EIFFEL_SERVER_GENERATOR

inherit
	WIZARD_COCLASS_EIFFEL_GENERATOR
		redefine
			generate
		end

	WIZARD_COMPONENT_EIFFEL_SERVER_GENERATOR 
		redefine
			set_default_ancestors
		end

feature --  Basic operations

	generate (a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate eiffel class for coclass.
		local
			server_impl_generator: WIZARD_COCLASS_EIFFEL_SERVER_IMPL_GENERATOR
		do
			Precursor {WIZARD_COCLASS_EIFFEL_GENERATOR} (a_coclass)

			add_default_features (a_coclass)
			eiffel_writer.set_deferred

			check
				valid_writer: eiffel_writer.can_generate
			end
			Shared_file_name_factory.create_file_name (Current, eiffel_writer)
			eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)

			eiffel_writer := Void

			-- Server Implementation
			create server_impl_generator
			server_impl_generator.generate (a_coclass)
		end

	process_interfaces (a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Process coclass interfaces.
		local
			interface_processor: WIZARD_COCLASS_INTERFACE_EIFFEL_SERVER_PROCESSOR
		do
			create interface_processor.make (a_coclass, eiffel_writer)
			interface_processor.process_interfaces
			dispatch_interface := interface_processor.dispatch_interface
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_coclass_eiffel_server
		end

feature {NONE} -- Implementation

	set_default_ancestors (an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS) is
			-- Set default ancestors.
		local
			inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE
		do
			create inherit_clause.make
			inherit_clause.set_name ("ECOM_STUB")
			an_eiffel_writer.add_inherit_clause (inherit_clause)
		end

	add_default_features (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate process dependent feature.
		do
		end

	add_creation is
			-- Add creation procedures.
		do
		end

end -- class WIZARD_COCLASS_EIFFEL_SERVER_GENERATOR

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

