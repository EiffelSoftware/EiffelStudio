indexing
	description: "Record c server generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RECORD_C_SERVER_GENERATOR

inherit
	WIZARD_RECORD_C_GENERATOR
		redefine
			generate
		end


feature -- Access

	generate (a_descriptor: WIZARD_RECORD_DESCRIPTOR) is
			-- Generate c server for record.
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
			a_factory.process_record_c_server
		end

end -- class WIZARD_RECORD_C_SERVER_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
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
