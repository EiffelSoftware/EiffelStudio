indexing
	description	: "Command to execute an external wizard"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_EXTERNAL_WIZARD

inherit
	EIFFEL_ENV
		export
			{NONE} all
		end

	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	EB_ERROR_MANAGER
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end
		
	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_location: DIRECTORY_NAME) is
			-- Create a new external wizard located in `a_location'.
			--
			-- Note: `a_location' should contains a directory `resources',
			-- `pixmap' and `spec' (with a subdirectory per Operating System).
		require
			valid_location: 
				a_location /= Void and then 
				not a_location.is_empty and then
				(create {DIRECTORY}.make (a_location)).exists
		do
			location := a_location
		end

feature -- Execution

	execute is	
			-- Execute the wizard
		local
			temp_filename: FILE_NAME
			temp_file: PLAIN_TEXT_FILE
			wizard_launched: BOOLEAN
		do
			create temp_filename.make_temporary_name
			create temp_file.make (temp_filename)
			temp_file.open_write
			temp_file.put_string ("Success=%"<SUCCESS>%"%N")
			if Additional_parameters /= Void then
				temp_file.put_string (Additional_parameters)
			end
			temp_file.close

			launch_wizard (temp_filename)
			wizard_launched := True
		rescue
			if error_messages.is_empty then
				set_error_message ("Unable to create the temporary file required to launch the wizard")
			end
		end

	Additional_parameters: STRING is
			-- Additional parameters
		deferred
		end

	result_parameters: LINKED_LIST [ARRAY [STRING]]
			-- Parameters returned by the Wizard.

	successful: BOOLEAN
			-- Was the execution of the wizard successful?

feature {NONE} -- Implementation

	launch_wizard (callback_filename: STRING) is
			-- Launch the wizard using the file `callback_filename' as callback.
		local
			wizard_exec_filename: FILE_NAME
			wizard_exec_file: RAW_FILE
			wizard_command: STRING
		do
			create wizard_exec_filename.make_from_string (location)
			wizard_exec_filename.extend ("spec")
			wizard_exec_filename.extend (eiffel_platform)
			wizard_exec_filename.set_file_name ("wizard")
			if not Platform_constants.Executable_suffix.is_empty then
				wizard_exec_filename.add_extension (Platform_constants.Executable_suffix)
			end
			
			create wizard_exec_file.make (wizard_exec_filename)
			if not (wizard_exec_file.exists and then wizard_exec_file.is_executable) then
				set_error_message (Warning_messages.w_Unable_to_execute_wizard (wizard_exec_filename))
				(create {EXCEPTIONS}).raise (Interface_names.Workbench_name+" Exception")
			end
			
			create wizard_command.make (0)
			wizard_command.append (wizard_exec_filename)
			wizard_command.append (" ")
			wizard_command.append ("%""+location+"%"")
			wizard_command.append (" -callback %""+callback_filename+"%"")
			launch (wizard_command)
			wait_for_finish (callback_filename)
		end

	wait_for_finish (callback_filename: STRING) is
			-- Wait for the end of the Wizard, and collect the results.
		local	
			retry_count: INTEGER
			finished: BOOLEAN
			callback_file: PLAIN_TEXT_FILE
			analysed_line: ARRAY[STRING]
		do
			from
				create callback_file.make (callback_filename)
			until
				finished
			loop
				create result_parameters.make
				wait
				from
					callback_file.open_read
				until
					callback_file.end_of_file
				loop
					callback_file.readline
					if not callback_file.last_string.is_empty and then callback_file.last_string.index_of ('=', 1) /= 0 then
						analysed_line := analyse_line (callback_file.last_string)
						result_parameters.extend (analysed_line)
						if (analysed_line @ 1).is_equal ("success") and then 
							not (analysed_line @ 2).is_equal ("<SUCCESS>") 
						then
							finished := True
							(analysed_line @ 2).to_lower
							if (analysed_line @ 2).is_equal ("yes") then
								successful := True
							end
						end
					end
				end
				callback_file.close
			end
		rescue
			if retry_count < 10 then
				retry_count := retry_count + 1
				ev_application.sleep (100)
				retry
			end
		end

	wait is
			-- Wait for one second (but process events) and return.
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i >= 10
			loop
				ev_application.sleep (10)
				ev_application.process_events
				i := i + 1
			end
		end

	analyse_line (a_line: STRING): ARRAY [STRING] is
			-- Separate a line "Name=Value" into an array of 2 elements.
			-- The first element contains the name in lower case, the second
			-- contains the value.
		local
			equal_index: INTEGER
			loc_name: STRING
			loc_value: STRING
		do
			equal_index := a_line.index_of ('=', 1)
			if equal_index /= 0 then
				loc_name := adjust_string (a_line.substring (1, equal_index - 1))
				loc_value := adjust_string (a_line.substring (equal_index + 1, a_line.count))
				loc_name.to_lower

				create Result.make (1, 2)
				Result.put (loc_name, 1)
				Result.put (loc_value, 2)
			end
		end

	adjust_string (a_string: STRING): STRING is
			-- Remove any blank character and quote at beginning and
			-- and of the string.
		do
			Result := clone (a_string)

			Result.left_adjust
			Result.right_adjust
			if (Result @ 1) = '"' then
				Result.tail (Result.count - 1)
				Result.head (Result.count - 1)
			end
			Result.left_adjust
			Result.right_adjust
		end

feature {NONE} -- Private attributes

	location: DIRECTORY_NAME
			-- Location of this wizard.

end -- class EB_EXTERNAL_WIZARD
