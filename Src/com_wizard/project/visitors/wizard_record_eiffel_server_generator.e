indexing
	description: "Record eiffel server generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RECORD_EIFFEL_SERVER_GENERATOR

inherit
	WIZARD_RECORD_EIFFEL_GENERATOR
		redefine
			generate
		end


feature -- Access

	generate (a_descriptor: WIZARD_RECORD_DESCRIPTOR) is
			-- Generate eiffel server for record
		do
			if not standard_structures.has (a_descriptor.c_type_name) then
				Precursor (a_descriptor)
				Shared_file_name_factory.create_file_name (Current, eiffel_writer)
				eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)
			end

			eiffel_writer := Void
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_record_eiffel_server
		end

			
end -- class WIZARD_RECORD_EIFFEL_SERVER_GENERATOR

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

