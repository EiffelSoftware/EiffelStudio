indexing
	description: "Resource file generator."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RESOURCE_FILE_GENERATOR

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
			{ANY} client
			{ANY} server
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

feature -- Access

	Resource_file_extension: STRING is ".rc"
			-- Resource file extension

feature -- Basic operations

	generate (a_folder: STRING) is
			-- Generate resource file in `a_folder'.
		require
			non_void_folder: a_folder /= Void
			valid_folder: a_folder.is_equal (Client) or a_folder.is_equal (Server)
		local
			a_string: STRING
			a_file: RAW_FILE
		do
			create a_string.make (500)
			a_string.append (shared_wizard_environment.destination_folder)
			a_string.append (a_folder)
			a_string.append_character (Directory_separator)
			a_string.append (Resource_file_name)
			create a_file.make_create_read_write (a_string)
			a_file.put_string (generated_resource_file)
			a_file.close
		end

	Generated_resource_file: STRING is 
			-- Resource file content
		local
			str_buffer: STRING
		do
			create Result.make (100)
			Result.append ("1 typelib ")
			Result.append (Double_quote)
			
			str_buffer := clone (Shared_wizard_environment.type_library_file_name)
			str_buffer.replace_substring_all ("%H", "%H%H")

			Result.append (str_buffer)
			Result.append (Double_quote)
		end

	Resource_file_name: STRING is
			-- Resource file name
		do
			create Result.make (100)
			Result.append (Shared_wizard_environment.project_name)
			Result.append (Resource_file_extension)
		end

end -- class WIZARD_RESOURCE_FILE_GENERATOR

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
