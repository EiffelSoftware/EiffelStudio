indexing
	description: "Record c client generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RECORD_C_CLIENT_GENERATOR

inherit
	WIZARD_RECORD_C_GENERATOR
		redefine
			generate
		end


feature -- Access

	generate (a_descriptor: WIZARD_RECORD_DESCRIPTOR) is
			-- Generate c client for record.
		do
			if not standard_structures.has (a_descriptor.c_type_name) then
				Precursor (a_descriptor)
				Shared_file_name_factory.create_file_name (Current, c_writer)
				c_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)
				Shared_file_name_factory.create_file_name (Current, c_writer_impl)
				c_writer_impl.save_header_file (Shared_file_name_factory.last_created_header_file_name)
			end
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
			-- Create file name.
		do
			a_factory.process_record_c_client
		end

			
end -- class WIZARD_RECORD_C_CLIENT_GENERATOR

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

