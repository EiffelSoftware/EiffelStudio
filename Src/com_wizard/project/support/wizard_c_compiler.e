class
	WIZARD_C_COMPILER

inherit
	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_ROUTINES

	WIZARD_PROCESS_LAUNCHER
		rename
			message_output as process_launcher_message_output
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

	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_RESCUABLE
		export
			{NONE} all
		end

create
	make

feature -- Basic Operations

	compile_folder (a_folder_name: STRING) is
			-- Compiler C files in folder `a_folder_name'.
			-- Report progress with `a_progress_report' if not void.
		require
			non_void_folder_name: a_folder_name /= Void
			valid_folder_name: is_valid_folder_name (a_folder_name)
		local
			a_directory: DIRECTORY
			a_file_list: LIST [STRING]
			a_file: RAW_FILE
			a_working_directory, a_string: STRING
		do
			a_working_directory := clone (current_working_directory)
			create a_directory.make_open_read (a_folder_name)
			a_file_list := a_directory.linear_representation
			progress_report.start
			progress_report.set_range (a_file_list.count)
			change_working_directory (a_folder_name)
			from
				a_file_list.start
			until
				a_file_list.after or Shared_wizard_environment.abort
			loop
				if is_c_file (a_file_list.item) then
					if a_folder_name.is_equal (Common) then
						if Shared_wizard_environment.client then
							generate_make_file (C_compiler_common_client_command_line (a_file_list.item), Temporary_input_file_name)
						else
							generate_make_file (C_compiler_common_server_command_line (a_file_list.item), Temporary_input_file_name)
						end
					else
						generate_make_file (C_compiler_standard_command_line (a_file_list.item), Temporary_input_file_name)
					end
					a_string := clone (C_compiler)
					a_string.append (Space)
					a_string.append (last_make_command)
					launch (a_string, current_working_directory)
					check_return_code
				end
				progress_report.step
				a_file_list.forth
			end
			change_working_directory (a_working_directory)
		end
	
	compile_file (a_file_name: STRING) is
			-- Compile C file `a_file_name'.
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: is_c_file (a_file_name)
		local
			a_string: STRING
		do
			generate_make_file (C_compiler_command_line (a_file_name), Temporary_input_file_name)
			a_string := clone (C_compiler)
			a_string.append (Space)
			a_string.append (last_make_command)
			launch (a_string, current_working_directory)
			check_return_code
		end
	
	link_all (a_folder_name, a_library_name: STRING) is
			-- Link all object files in current directory into
			-- `a_library_name'.lib
		require
			non_void_library_name: a_library_name /= Void
			valid_library_name: not a_library_name.empty and not a_library_name.has ('.')
			non_void_folder_name: a_folder_name /= Void
			valid_folder_name: is_valid_folder_name (a_folder_name)
		local
			a_file_list: LIST [STRING]
			a_string, an_object_file_list: STRING
			a_directory: DIRECTORY
		do
			create a_directory.make_open_read (a_folder_name)
			a_file_list := a_directory.linear_representation
			from
				a_file_list.start
				create an_object_file_list.make (20)
			until
				a_file_list.after
			loop
				if is_object_file (a_file_list.item) then
					an_object_file_list.append (a_file_list.item)
					an_object_file_list.append (Space)
				end
				a_file_list.forth
			end
			a_string := clone (Lib_command)
			a_string.append (Space)
			a_string.append (Lib_out_option)
			a_string.append (a_library_name)
			a_string.append (Lib_file_extension)
			a_string.append (Space)
			a_string.append (an_object_file_list)
			launch (a_string, a_folder_name)
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
				if Shared_wizard_environment.stop_on_error then
					shared_wizard_environment.set_abort (last_process_result)
				end
			end
		end

	last_make_command: STRING
			-- Input to compiler
			-- Set by `generate_make_file'.

	generate_make_file (content, title: STRING) is
			-- Generate makefile with content `content' and file name `title'.
			-- Set `last_make_command' with argument to pass to compiler.
		local
			retried: BOOLEAN
			a_file: PLAIN_TEXT_FILE
			a_string: STRING
		do
			if not retried then
				a_string := clone (current_working_directory)
				a_string.append_character (Directory_separator)
				a_string.append (title)
				create a_file.make_open_write (a_string)
				a_file.put_string (content)
				last_make_command := clone (At_sign)
				last_make_command.append (title)
				a_file.close
			else
				message_output.add_error (Current, message_output.Could_not_write_makefile)
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
			Result := clone (Common_c_compiler_options)
			if Shared_wizard_environment.output_level = message_output.Output_none then
				Result.append (" /nologo ")
			end
			Result.append (clone (current_working_directory))
			Result.append_character (Directory_separator)
			Result.append (a_file_name)
		end

	C_compiler_standard_command_line (a_file_name: STRING): STRING is
			-- Standard Cl commmand line used to compile generated code (Server and Client folders)
		do
			Result := clone (Common_standard_c_compiler_options)
			Result.append (clone (current_working_directory))
			Result.append_character (Directory_separator)
			Result.append (a_file_name)
		end

	C_compiler_common_client_command_line (a_file_name: STRING): STRING is
			-- Standard Cl commmand line used to compile generated code (Commont folder for client)
		do
			Result := clone (Client_standard_c_compiler_options)
			Result.append (clone (current_working_directory))
			Result.append_character (Directory_separator)
			Result.append (a_file_name)
		end

	C_compiler_common_server_command_line (a_file_name: STRING): STRING is
			-- Standard Cl commmand line used to compile generated code (Common folder for server)
		do
			Result := clone (Server_standard_c_compiler_options)
			Result.append (clone (current_working_directory))
			Result.append_character (Directory_separator)
			Result.append (a_file_name)
		end

end -- class WIZARD_C_COMPILER
