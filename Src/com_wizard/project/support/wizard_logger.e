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
		do
			log_file.close
			Shared_log_file_cell.replace (Void)
			generated_files_file.close
			Shared_generated_files_file_cell.replace (Void)
		end

	add_log (a_origin: ANY; a_log_text: STRING) is
			-- Add `a_log_text' to log.
		local
			a_date_time: DATE_TIME
			a_string: STRING
			an_integer, i: INTEGER
		do
			create a_date_time.make_now
			a_string := a_date_time.out
			a_string.append (Tab)
			a_string.append (a_origin.generator)
			a_string.append (New_line_tab)
			a_string.append (a_log_text)
			a_string.append (New_line)
			a_string.append (New_line)
			log_file.put_string (a_string)
		end

feature {NONE} -- Implementation

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
  