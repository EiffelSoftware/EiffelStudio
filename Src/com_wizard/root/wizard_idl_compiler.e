class
	WIZARD_IDL_COMPILER

inherit
	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_PROCESS_LAUNCHER
		export
			{NONE} all
		end

	WIZARD_COMPILER_ENVIRONMENT
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

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	WIZARD_ROUTINES
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

	WEL_SW_CONSTANTS
		export
			{NONE} all
		end
		
create
	make

feature -- Basic Operations

	compile_idl is
			-- Compile idl file pointed by `idl_file_name'.
			-- Set `shared_wizard_environment.type_library_file_name' with
			-- resulting type library file name.
		local
			a_string: STRING
		do
			a_string := "%""
			a_string.append (clone (shared_wizard_environment.destination_folder))
			if a_string.last_index_of (Directory_separator, 1) /= a_string.count then
				a_string.append_character (Directory_separator)
			end
			a_string.append (clone (shared_wizard_environment.project_name))
			a_string.append (".tlb")
			shared_wizard_environment.set_type_library_file_name (a_string)
			a_string.append ("%"")
			launch (Idl_compiler_command_line, shared_wizard_environment.destination_folder)
			check_return_code
		end

	compile_iid is
			-- Compile iid C file.
		do
			launch (C_compiler_command_line (Generated_iid_file_name), shared_wizard_environment.destination_folder)
			check_return_code
		end
	
	compile_ps is
			-- Compile proxy/stub C file.
		do
			launch (C_compiler_command_line (Generated_ps_file_name), shared_wizard_environment.destination_folder)
			check_return_code
		end

	compile_data is
			-- Compile dlldata C file.
		do
			launch (C_compiler_command_line (Generated_dlldata_file_name), shared_wizard_environment.destination_folder)
			check_return_code
		end

	link is
			-- Create proxy/stub dll.
		local
			a_string: STRING
		do
			generate_def_file
			launch (Linker_command_line, shared_wizard_environment.destination_folder)
			check_return_code
			a_string := ("%"")
			a_string := clone (shared_wizard_environment.destination_folder)
			a_string.append (clone (shared_wizard_environment.project_name))
			a_string.append ("%"")
			shared_wizard_environment.set_proxy_stub_file_name (a_string)
		end

feature {NONE} -- Implementation

	check_return_code is
			-- Display error message and stops execution if last system call failed
		do
			if last_process_result /= 0 or not last_launch_successful then
				shared_wizard_environment.set_abort (last_process_result)
			end
		end

	Proxy_stub_file_name: STRING is
			-- Proxy/Stub fil name
		once
			Result := clone (shared_wizard_environment.destination_folder)
			Result.append_character (directory_separator)
			Result.append (shared_wizard_environment.project_name)
			Result.append ("_ps.dll")
		end

	generate_def_file is
			-- Generate standard COM def file in current folder.
		local
			a_file: RAW_FILE
			a_string: STRING
		do
			a_string := current_working_directory
			change_working_directory (shared_wizard_environment.destination_folder)
			create a_file.make (Def_file_name)
			if not a_file.exists then
				a_file.make_create_read_write (Def_file_name)
				a_file.put_string ("DESCRIPTION %"EiffelCOM Generated Component%"%N")
				a_file.put_string ("EXPORTS%N")
				a_file.put_string ("%TDllGetClassObject%T%T@1 PRIVATE%N")
				a_file.put_string ("%TDllCanUnloadNow%T%T%T@2 PRIVATE%N")
				a_file.put_string ("%TDllRegisterServer%T%T@3 PRIVATE%N")
				a_file.put_string ("%TDllUnregisterServer%T@4 PRIVATE%N")
				a_file.close
			end
			change_working_directory (a_string)
		end

	Idl_compiler_command_line: STRING is
			-- MIDL command line
		do
			Result := "%""
			Result.append (Idl_compiler)
			Result.append (" ")
			Result.append (Common_idl_compiler_options)
			Result.append ("  /out \%"")
			Result.append (clone (shared_wizard_environment.destination_folder))
			Result.append ("\%" /h \%"")
			Result.append (Generated_header_file_name)
			Result.append ("\%" /dlldata \%"")
			Result.append (Generated_dlldata_file_name)
			Result.append ("\%" /iid \%"")
			Result.append (Generated_iid_file_name)
			Result.append ("\%" /proxy \%"")
			Result.append (Generated_ps_file_name)
			Result.append ("\%" /tlb \%"")
			Result.append (clone (shared_wizard_environment.project_name))
			Result.append (".tlb")
			Result.append ("\%" \%"")
			Result.append (shared_wizard_environment.idl_file_name)
			Result.append ("\%"%"")
		end

	C_compiler_command_line (file_name: STRING): STRING is
			-- Cl command line
		do
			Result := "%""
			Result.append (clone (C_compiler))
			Result.append (" ")
			Result.append (Common_c_compiler_options)
			Result.append ("\%"")
			Result.append (clone (shared_wizard_environment.destination_folder))
			Result.append_character (directory_separator)
			Result.append (file_name)
			Result.append ("\%"%"")
		end

	Linker_command_line: STRING is
			-- Link command line
		local
			a_string: STRING
		do
			Result := "%""
			Result.append (clone (Linker))
			Result.append (" ")
			Result.append (Common_linker_options)
			Result.append (" /OUT:")
			Result.append ("\%"")
			Result.append (Proxy_stub_file_name)
			Result.append ("\%"")
			Result.append (" /DEF:")
			Result.append (clone (Def_file_name))
			a_string := clone (shared_wizard_environment.destination_folder)
			a_string.append_character (directory_separator)
			a_string.append (c_to_obj (Generated_iid_file_name))
			Result.append (" ")
			Result.append ("\%"")
			Result.append (a_string)
			Result.append ("\%"")
			a_string := clone (shared_wizard_environment.destination_folder)
			a_string.append_character (directory_separator)
			a_string.append (c_to_obj (Generated_ps_file_name))
			Result.append (" ")
			Result.append ("\%"")
			Result.append (a_string)
			Result.append ("\%"")
			a_string := clone (shared_wizard_environment.destination_folder)
			a_string.append_character (directory_separator)
			a_string.append (c_to_obj (Generated_dlldata_file_name))
			Result.append (" ")
			Result.append ("\%"")
			Result.append (a_string)
			Result.append ("\%" ")
			Result.append (Rpc_library)
			Result.append ("%"")
		end

end -- class WIZARD_IDL_COMPILER