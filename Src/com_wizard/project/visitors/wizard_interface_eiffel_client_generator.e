indexing
	description: "Interface eiffel client generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INTERFACE_EIFFEL_CLIENT_GENERATOR

inherit
	WIZARD_INTERFACE_EIFFEL_GENERATOR
		redefine
			generate
		end


feature -- Basic operation

	generate (a_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Generate eiffel writer
		do
			precursor (a_descriptor)

			Shared_file_name_factory.create_file_name (Current, eiffel_writer)
			eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)

			eiffel_writer := Void
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_interface_eiffel_client
		end

end -- class WIZARD_INTERFACE_EIFFEL_CLIENT_GENERATOR

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

