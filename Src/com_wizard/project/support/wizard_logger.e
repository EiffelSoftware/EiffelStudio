indexing
	description: "Log generation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_LOGGER

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_RESCUABLE
		export
			{NONE} all
		end

feature -- Access

	log_file: PLAIN_TEXT_FILE is
			-- Generation log file
		do
			Result := Shared_log_file_cell.item
		end

	generated_files_file: PLAIN_TEXT_FILE is
			-- Generation log file
		do
			Result := Shared_generated_files_file_cell.item
		end
 
	log_file_exists: BOOLEAN is
			-- Was log file correctly initialized?
		do
			Result := log_file /= Void
		end

	Title, Message, Warning, Error: INTEGER is unique
			-- Log types

feature -- Basic operations

	initialize_log_file is
			-- Open log file for current project.
		local
			retried: BOOLEAN
			a_path: STRING
		do
			if not retried then
				a_path := clone (Shared_wizard_environment.destination_folder)
				a_path.append (Shared_wizard_environment.project_name)
				a_path.append (Log_file_extension)
				Shared_log_file_cell.replace (create {PLAIN_TEXT_FILE}.make_open_write (a_path))
				a_path := clone (Shared_wizard_environment.destination_folder)
				a_path.append (Generated_files_file_name)
				Shared_generated_files_file_cell.replace (create {PLAIN_TEXT_FILE}.make_open_write (a_path))
			end
		rescue
			if not failed_on_rescue then
				retried := True
				retry
			end
		end

	close_log_file is
			-- Close log file.
		local
			retried: BOOLEAN
		do
			if not retried then
				log_file.close
				Shared_log_file_cell.replace (Void)
				generated_files_file.close
				Shared_generated_files_file_cell.replace (Void)
			end
		rescue
			if not failed_on_rescue then
				retried := True
				retry
			end
		end

	add_log (a_type: INTEGER; a_origin: ANY; a_log_text: STRING) is
			-- Add `a_log_text' of type `a_type' from `a_origin' to log.
		local
			a_date_time: DATE_TIME
			a_string: STRING
		do
			create a_date_time.make_now
			a_string := clone (type_title.item (a_type))
			a_string.append (Tab)
			a_string.append (a_date_time.out)
			a_string.append (Tab)
			a_string.append (a_origin.generator)
			a_string.append (New_line_tab)
			a_string.append (a_log_text)
			a_string.append (New_line)
			a_string.append (New_line)
			if log_file /= Void then
				log_file.put_string (a_string)
			end
		end

feature {NONE} -- Implementation

	type_title: HASH_TABLE [STRING, INTEGER] is
			-- Log types title table
		once
			create Result.make (3)
			Result.put (Title_title, Title)
			Result.put (Message_title, Message)
			Result.put (Warning_title, Warning)
			Result.put (Error_title, Error)
		end

	Title_title: STRING is "TITLE:"
			-- Title log type title

	Message_title: STRING is "MESSAGE:"
			-- Message log type title

	Warning_title: STRING is "WARNING:"
			-- Warning log type title

	Error_title: STRING is "ERROR:"
			-- Error log type title

	Shared_log_file_cell: CELL [PLAIN_TEXT_FILE] is
			-- Log file cell
		once
			create Result.put (Void)
		end

	Shared_generated_files_file_cell: CELL [PLAIN_TEXT_FILE] is
			-- File including list of generated files file cell
		once
			create Result.put (Void)
		end

	Log_file_extension: STRING is ".log"
			-- Log file extension

	Max_generator_size: INTEGER is 60
			-- Max log origin class name length

	Tab_size: INTEGER is 8
			-- Number of characters per tabulation

end -- class WIZARD_LOGGER

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
  