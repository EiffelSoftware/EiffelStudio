indexing
	description: "Code generation manager."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_MANAGER

inherit
	WIZARD_CLEANER	
		export
			{NONE} all
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end


	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	EXCEPTIONS
		export
			{NONE} all
		end

	WIZARD_RESCUABLE
		export
			{NONE} all
		end

	WIZARD_FILE_SYSTEM_MANAGEMENT
		export
			{NONE} all
		end

feature -- Access

	Idl_compilation_title: STRING is "IDL Compilation"
			-- IDL compilation title.
	
	Iid_compilation_title: STRING is "C Compilation step 1"
			-- Iid generated C file compilation title.
	
	Data_compilation_title: STRING is "C Compilation step 2"
			-- Inprocess dll generated C file compilation title.
	
	Ps_compilation_title: STRING is "C Compilation step 3"
			-- Proxy/stub generated C file compilation title.
	
	Link_title: STRING is "Creating Proxy Stub Dll"
			-- Link title.

	Analysis_title: STRING is "Analysing Type Library"
			-- Analysis title.

feature -- Basic Operations

	run is
			-- Start generation.
		local
			idl_file_generator: WIZARD_IDL_GENERATOR
		do
			if shared_wizard_environment.project_name /= Void then 
				message_output.add_title (Current, 
						"Processing %"" + shared_wizard_environment.project_name + "%"")
			end
			if not shared_wizard_environment.abort then
				message_output.initialize_log_file

				if Eiffel4_location = Void or else Eiffel4_location.is_empty then
					message_output.add_error (Current, message_output.Eiffel4_not_set)
				end
			end
			
			if 
				shared_wizard_environment.new_eiffel_project and
				not shared_wizard_environment.abort
			then
				progress_report.set_title ("Processing Eiffel class")
				progress_report.start
				progress_report.set_range (2)

				create idl_file_generator.make (message_output)
				progress_report.step
				idl_file_generator.generate
				progress_report.step
			end

			-- Compile IDL
			if 
				shared_wizard_environment.idl and
				not shared_wizard_environment.abort
			then
				progress_report.set_title (Idl_compilation_title)
				progress_report.start

				if 
					Shared_wizard_environment.client or
					shared_wizard_environment.use_universal_marshaller or
					shared_wizard_environment.automation or
					shared_wizard_environment.new_eiffel_project
				then
					progress_report.set_range (1)
				else
					progress_report.set_range (6)
				end
				message_output.add_title (Current, Idl_compilation_title)

				compiler.compile_idl
				progress_report.step


				-- Create Proxy/Stub
				if 
					Shared_wizard_environment.server and 
					not shared_wizard_environment.use_universal_marshaller and 
					not shared_wizard_environment.automation and
					not shared_wizard_environment.new_eiffel_project and
					not shared_wizard_environment.abort
				then
					check
						not_client: not Shared_wizard_environment.client
					end
					message_output.add_title (Current, Iid_compilation_title)
					compiler.compile_iid
					if not shared_wizard_environment.abort then
						progress_report.step
						message_output.add_title (Current, Data_compilation_title)
						compiler.compile_data
					end
					if not shared_wizard_environment.abort then
						progress_report.step
						message_output.add_title (Current, Ps_compilation_title)
						compiler.compile_ps
					end
					if not shared_wizard_environment.abort then
						progress_report.step
						message_output.add_title (Current, Link_title)
						compiler.link
					end
					if not shared_wizard_environment.abort then
						progress_report.step
						message_output.add_title (Current, Ps_registration_title)
						compiler.register_ps
					end
					if not shared_wizard_environment.abort then
						progress_report.step
					end
				
				end
			end
			if Shared_wizard_environment.abort then
				message_output.close_log_file
				finish
			else
				generate
				message_output.close_log_file
			end
		rescue
			if not failed_on_rescue then
				shared_wizard_environment.set_abort (Standard_abort_value)
				message_output.close_log_file
				retry
			end
		end

feature {NONE} -- Implementation

	generate is
			-- Generate Eiffel/C++ code.
		do
			intialize_file_directories
			if directories_initialized then
				analyze_type_library
				generate_code
				set_system_descriptor (Void)
				if Shared_wizard_environment.compile_c then
					compile_code
				end
			end
			clean_all
			progress_report.finish
		end
	
	analyze_type_library is
			-- Generate descriptors
		do
			message_output.add_title (Current, Analysis_title)
			set_system_descriptor (create {WIZARD_SYSTEM_DESCRIPTOR}.make)
			progress_report.set_range (0)
			progress_report.set_progress (0)
			progress_report.set_title (Analysis_title)
			progress_report.start
			system_descriptor.generate (shared_wizard_environment.type_library_file_name)
		end

	generate_code is
			-- Generate code.
		local
			code_generator: WIZARD_CODE_GENERATOR
		do
			create code_generator.make
			code_generator.generate
			compiler.set_ace_file_generated (code_generator.ace_file_generated)
			compiler.set_resource_file_generated (code_generator.resource_file_generated)
			compiler.set_makefile_generated (code_generator.makefile_generated)
			code_generator := Void
		end

	compile_code is
			-- Compile code.
		local
			Clib_folder_name: STRING
		do
			-- Set ISE_EIFFEL environment variable.
			execution_environment.put (Eiffel4_location, Ise_eiffel)
			
			-- Compiling generated C code
			message_output.add_title (Current, Compilation_title_c)
			execution_environment.change_working_directory (shared_wizard_environment.destination_folder)
			if not shared_wizard_environment.abort then
				Clib_folder_name := clone (Client)
				Clib_folder_name.append_character (Directory_separator)
				Clib_folder_name.append (Clib)
				progress_report.set_title (C_client_compilation_title)
				progress_report.set_range (1)
				progress_report.start
				compiler.compile_folder (Clib_folder_name)
				progress_report.step
			end
			if not shared_wizard_environment.abort then
				Clib_folder_name := clone (Server)
				Clib_folder_name.append_character (Directory_separator)
				Clib_folder_name.append (Clib)
				progress_report.set_title (C_server_compilation_title)
				progress_report.set_range (1)
				progress_report.start
				compiler.compile_folder (Clib_folder_name)
				progress_report.step
			end
			if 
				not shared_wizard_environment.abort 
			then		
				message_output.add_message (Current, Compilation_Successful)
			else
				message_output.add_error (Current, Compilation_failed)
			end
			
			-- Compiling Eiffel
			if not Shared_wizard_environment.abort and Shared_wizard_environment.compile_eiffel then
				message_output.add_title (Current, Compilation_title_eiffel)
				if Shared_wizard_environment.client then
					progress_report.set_title (Eiffel_compilation_title)
					progress_report.set_range (1)
					progress_report.start
					compiler.compile_eiffel (Client)
					progress_report.step
				
				elseif 
					Shared_wizard_environment.server 
				then
					progress_report.set_title (Eiffel_compilation_title)
					progress_report.set_range (1)
					progress_report.start
					compiler.compile_eiffel (Server)
					progress_report.step
				end
			end
			if 
				not shared_wizard_environment.abort 
			then		
				message_output.add_title (Current, Compilation_Successful)
			else
				message_output.add_error (Current, Compilation_failed)
			end
		end

	finish is
			-- Abort code generation.
		local
			a_string: STRING
		do
			inspect
				Shared_wizard_environment.return_code
			when Standard_abort_value then
				a_string := clone (Standard_failure_error_message)
			else
				a_string := clone (Failed_message)
				a_string.append_integer (Shared_wizard_environment.return_code)
			end
			message_output.add_error (Current, a_string)
			if progress_report.running then
				progress_report.finish
			end
		end

	compiler: WIZARD_COMPILER is
			-- IDL/C compiler.
		once
			create Result.make (message_output)
		end

	initialize_subdirectory (a_path, a_subdirectory: STRING) is
			-- Initialize `a_subdirectory' folder relative to `a_path'.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			non_void_subdirectory: a_subdirectory /= Void
			valid_subdirectory: not a_subdirectory.is_empty
		local
			a_path2: STRING
		do
			a_path2 := clone (a_path)
			a_path2.append (a_subdirectory)
			initialize_directory (a_path2)
		end
		
	initialize_clib_include (a_path: STRING) is
			-- Initialize Clib and Include folders relative to `a_path'.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		do
			initialize_subdirectory (a_path, Clib)
			initialize_subdirectory (a_path, Include)
		end

	intialize_file_directories is
			-- Create generated files directories.
		local
			a_path, a_path2: STRING
		do
			-- Initialize Common subdirectory
			a_path := clone (shared_wizard_environment.destination_folder)
			initialize_subdirectory (a_path, Common)

			a_path2 := clone (a_path)
			a_path2.append (Common)
			a_path2.append_character (Directory_separator)
			initialize_clib_include (a_path2)
			
			initialize_subdirectory (a_path2, Interfaces)
			initialize_subdirectory (a_path2, Structures)

			-- Initialize Client subdirectory
			initialize_subdirectory (a_path, Client)
			
			a_path2 := clone (a_path)
			a_path2.append (Client)
			a_path2.append_character (Directory_separator)
			initialize_clib_include (a_path2)

			initialize_subdirectory (a_path2, Component)
			initialize_subdirectory (a_path2, Interface_proxy)

			-- Initialize Server subdirectory
			initialize_subdirectory (a_path, Server)
			
			a_path2 := clone (a_path)
			a_path2.append (Server)
			a_path2.append_character (Directory_separator)
			initialize_clib_include (a_path2)

			initialize_subdirectory (a_path2, Component)
			initialize_subdirectory (a_path2, Interface_stub)

			directories_initialized := True
		end

	initialize_directory (a_path: STRING) is
			-- Create directory `a_path' if does not exist.
		require
			-- is_directory (a_path)
			-- only last directory in path is not created
		local
			a_file: RAW_FILE
			a_string: STRING
			a_directory: DIRECTORY
		do
			create a_file.make (a_path)
			if a_file.exists then
				if not a_file.is_directory then
					a_string := clone (message_output.File_already_exists)
					a_string.append (Colon)
					a_string.append (Space)
					a_string.append (a_path)
					message_output.add_warning (Current, a_string)
					message_output.add_message (Current, message_output.File_backed_up)
					a_string := clone (a_path)
					a_string.append (Backup_file_extension)
					file_copy (a_path, a_string)
					file_delete (a_path)
					create a_directory.make (a_path)
					check
						not_exists: not a_directory.exists
					end
					a_directory.create_dir
				end
			else
				create a_directory.make (a_path)
				check
					not_exists: not a_directory.exists
				end
				a_directory.create_dir
			end
		end
					
	directories_initialized: BOOLEAN
			-- Were directories correctly initialized?

	Failed_message: STRING is "Failed with return code "
			-- Failure message.
	
	Standard_failure_error_message: STRING is "Failed"
			-- Generic failure message.
	
	Compilation_title_c: STRING is "Compiling generated C code"
			-- Compilation message.

	Compilation_title_eiffel: STRING is "Compiling generated Eiffel code"
			-- Compilation message.

	C_client_compilation_title: STRING is "Compiling generated C client code"
			-- C compilation message.

	C_common_compilation_title: STRING is "Compiling generated C common code"
			-- C compilation message.

	C_server_compilation_title: STRING is "Compiling generated C server code"
			-- C compilation message.

	Compilation_successful: STRING is "Compilation completed."
			-- Compilation successful message.

	Compilation_failed: STRING is "Compilation failed."
			-- Compilation failed message.

	Eiffel_compilation_title: STRING is "Compiling Eiffel code"
			-- Eiffel compilation message.

	Ps_registration_title: STRING is "Registering Proxy/Stub"
			-- Proxy/Stub Registration

	cwin_create_process (a_name, a_command_line, a_sec_attributes1, a_sec_attributes2: POINTER;
							a_herit_handles: BOOLEAN; a_flags: INTEGER; an_environment, a_directory,
							a_startup_info, a_process_info: POINTER): BOOLEAN is
			-- SDK CreateProcess
		external
			"C [macro <winbase.h>] (LPCTSTR, LPTSTR, LPSECURITY_ATTRIBUTES, LPSECURITY_ATTRIBUTES, BOOL, DWORD, LPVOID, LPCTSTR, LPSTARTUPINFO, LPPROCESS_INFORMATION) :EIF_BOOLEAN"
		alias
			"CreateProcess"
		end


end -- class WIZARD_MANAGER

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
