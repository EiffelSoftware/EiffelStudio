class
	WIZARD_C_COMPILER

inherit
	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_ROUTINES

	WIZARD_PROCESS_LAUNCHER
		export
			{NONE} all
		end

	WIZARD_COMPILER_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_WRITER_DICTIONARY
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

feature -- Basic Operations

	compile_folder (a_folder_name: STRING) is
			-- Compiler C files in folder `a_folder_name'.
			-- Report progress with `a_progress_report' if not void.
		require
			non_void_folder_name: a_folder_name /= Void
			valid_folder_name: is_valid_folder_name (a_folder_name)
		local
			a_directory: DIRECTORY
			a_string: STRING
			displayed: BOOLEAN
		do
			displayed := displayed_while_running
			set_displayed_while_running (True)
			create a_directory.make_open_read (a_folder_name)
			if a_directory.has_entry ("Makefile." + Ise_c_compiler_value) then
				if Ise_c_compiler_value.is_equal ("msc") then
					a_string := "make_msc.bat"
				else
					check
						Ise_c_compiler_value.is_equal ("bcb")
					end
					a_string := "make_bcb.bat"
				end
				launch (a_string, a_folder_name)
				check_return_code
			end
			set_displayed_while_running (displayed)				
		end
	
	compile_file (a_file_name: STRING) is
			-- Compile C file `a_file_name'.
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: is_c_file (a_file_name)
		local
			a_string: STRING
		do
			generate_command_line_file (C_compiler_command_line (a_file_name), Temporary_input_file_name)
			a_string := C_compiler.twin
			a_string.append (Space)
			a_string.append (last_make_command)
			launch (a_string, Env.current_working_directory)
			check_return_code
		end

feature {NONE} -- Implementation

	Lib_command: STRING is "Lib"
			-- Link command

	Lib_out_option: STRING is "/OUT:"
			-- Lib out option

	check_return_code is
			-- Display error message and stops execution if last system call failed
		do
			if last_process_result /= 0 or not last_launch_successful then
				environment.set_abort (last_process_result)
			end
		end

	last_make_command: STRING
			-- Input to compiler
			-- Set by `generate_make_file'.

	generate_command_line_file (content, a_file_name: STRING) is
			-- Generate command line with content `content' and file name `a_file_name'.
			-- Set `last_make_command' with argument to pass to compiler.
		local
			retried: BOOLEAN
			a_file: PLAIN_TEXT_FILE
			a_string: STRING
		do
			if not retried then
				a_string := Env.current_working_directory.twin
				a_string.append_character (Directory_separator)
				a_string.append (a_file_name)
				create a_file.make_open_write (a_string)
				a_file.put_string (content)
				last_make_command := At_sign.twin
				last_make_command.append (a_file_name)
				a_file.close
			else
				message_output.add_error (Current, "Could not write makefile")
			end
		rescue
			if not failed_on_rescue then
				retried := True
				retry
			end
		end
		
	C_compiler_command_line (a_file_name: STRING): STRING is
			-- Cl command line used to compile Proxy Stub
		do
			Result := Common_c_compiler_options.twin
			Result.append (" /nologo ")
			Result.append (Env.current_working_directory.twin)
			Result.append_character (Directory_separator)
			Result.append (a_file_name)
		end

end -- class WIZARD_C_COMPILER

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
