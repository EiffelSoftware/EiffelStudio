indexing
	description: "Enum eiffel client generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ENUM_EIFFEL_CLIENT_GENERATOR

inherit
	WIZARD_ENUM_EIFFEL_GENERATOR
		redefine
			generate
		end


feature -- Access

	generate (a_descriptor: WIZARD_ENUM_DESCRIPTOR) is
			-- Generate eiffel client for enum.
			-- for every constant in `enum_descriptor'
				-- generate code for constant
		do
			Precursor (a_descriptor)
			Shared_file_name_factory.create_file_name (Current, eiffel_writer)
			eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)

			eiffel_writer := Void
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_enum_eiffel_client
		end
	
end -- class WIZARD_ENUM_EIFFEL_CLIENT_GENERATOR

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
