indexing
	description: "Generate code for a code element"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_WRITER

inherit
	WIZARD_MESSAGE_OUTPUT
		export
			{NONE} all
		end

	WEL_PROCESS_CREATION_CONSTANTS
		export
			{NONE} all
		end

	WEL_STARTUP_CONSTANTS
		export
			{NONE} all
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_MESSAGES
		export
			{NONE} all
		end

	WIZARD_RESCUABLE
		export
			{NONE} all
		end

	WIZARD_LOGGER
		export
			{NONE} all
		end

	WIZARD_FILE_SYSTEM_MANAGEMENT
		export
			{NONE} all
		end

feature -- Access

	generated_code: STRING is
			-- Generated code
		require
			ready: can_generate
		deferred
		end
	
	can_generate: BOOLEAN is
			-- Can code be generated?
		deferred
		end

feature -- Basic Operations

	save_file (a_file_name: STRING) is
			-- Save generated code in `a_file_name'.
		require
			can_generate: can_generate
		do
			save_content (a_file_name, generated_code)
		end

feature {NONE} -- Implementation

	save_content (a_file_name, a_content: STRING) is
			-- Save generated code in `a_file_name'.
		require
			can_generate: can_generate
		local
			a_file: PLAIN_TEXT_FILE
			retried: BOOLEAN
			a_string: STRING
		do
			a_file_name.to_lower
			generated_files_file.put_string (a_file_name)
			generated_files_file.put_string (New_line)
			a_file_name.to_lower
			if not retried then
				create a_file.make (a_file_name)
				if a_file.exists then
					a_string := clone (File_already_exists)
					a_string.append (Colon)
					a_string.append (Space)
					a_string.append (a_file_name)
					a_string.append (New_line)
					a_string.append (File_backed_up)
					add_warning (Current, a_string)
					file_delete (backup_file_name (a_file_name))
					file_copy (a_file_name, backup_file_name (a_file_name))
				end
				a_file.make_open_write (a_file_name)
				a_file.put_string (a_content)
				a_file.close
			else
				a_string := clone (Could_not_write_file)
				a_string.append (Colon)
				a_string.append (Space)
				a_string.append (a_file_name)
				add_error (Current, a_string)
			end
		rescue
			if not failed_on_rescue then
				retried := True
				retry
			end
		end

	backup_file_name (a_file_name: STRING): STRING is
			-- `a_file_name' backup file name
		local
			an_index: INTEGER
		do
			Result := clone (a_file_name)
			an_index := Result.last_index_of ('.', 1) - 1
			if an_index > 0 then
				Result.head (an_index)
			end
			Result.append (Backup_file_extension)
		end

end -- class WIZARD_WRITER

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
  