class
	WIZARD_COMPILER

inherit
	WIZARD_C_COMPILER

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_PROCESS_LAUNCHER
		export
			{NONE} all
		end

	WIZARD_ROUTINES
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
			intt: INTEGER
		do
			a_string := clone (Idl_compiler)
			a_string.append (Space)
			a_string.append (Idl_compiler_command_line)
			add_message (Current, a_string)
			a_string := clone (Shared_wizard_environment.destination_folder)
			a_string.append (clone (shared_wizard_environment.project_name))
			a_string.append (".tlb")
			shared_wizard_environment.set_type_library_file_name (a_string)
			change_working_directory (Shared_wizard_environment.destination_folder)
			generate_make_file (Idl_compiler_command_line, Temporary_input_file_name)
			a_string := clone (Idl_compiler)
			a_string.append (clone (Space))
			a_string.append (last_make_command)
			launch (a_string, Shared_wizard_environment.destination_folder)
			check_return_code
		end

	compile_iid is
			-- Compile iid C file.
		do
			compile_file (Generated_iid_file_name)
		end
	
	compile_ps is
			-- Compile proxy/stub C file.
		do
			compile_file (Generated_ps_file_name)
		end

	compile_data is
			-- Compile dlldata C file.
		do
			compile_file (Generated_dlldata_file_name)
		end
	
	link is
			-- Create proxy/stub dll.
		local
			a_string: STRING
		do
			generate_def_file
			a_string := clone (linker)
			a_string.append (Space)
			a_string.append (Linker_command_line)
			add_message (Current, a_string)
			generate_make_file (Linker_command_line, Temporary_input_file_name)
			a_string := clone (Linker)
			a_string.append (Space)
			a_string.append (last_make_command)
			launch (a_string, shared_wizard_environment.destination_folder)
			check_return_code
			a_string := clone (shared_wizard_environment.destination_folder)
			a_string.append (clone (shared_wizard_environment.project_name))
			a_string.append (Dll_file_extension)
			shared_wizard_environment.set_proxy_stub_file_name (a_string)
		end

	compile_eiffel (a_folder: STRING) is
			-- Compile Eiffel code in `a_folder'.
		do
		end

feature {NONE} -- Implementation

	Proxy_stub_file_name: STRING is
			-- Proxy/Stub fil name
		once
			Result := clone (shared_wizard_environment.destination_folder)
			Result.append_character (Directory_separator)
			Result.append (shared_wizard_environment.project_name)
			Result.append ("_ps.dll")
		end

	generate_def_file is
			-- Generate standard COM def file in current folder.
		local
			a_file: RAW_FILE
		do
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
		end

	Idl_compiler_command_line: STRING is
			-- MIDL command line
		do
			Result := clone (Common_idl_compiler_options)
			Result.append ("  /out %"")
			Result.append (clone (shared_wizard_environment.destination_folder))
			Result.append_character (Directory_separator)
			Result.append ("%" /h %"")
			Result.append (Generated_header_file_name)
			Result.append ("%" /dlldata %"")
			Result.append (Generated_dlldata_file_name)
			Result.append ("%" /iid %"")
			Result.append (Generated_iid_file_name)
			Result.append ("%" /proxy %"")
			Result.append (Generated_ps_file_name)
			Result.append ("%" /tlb %"")
			Result.append (clone (shared_wizard_environment.project_name))
			Result.append (".tlb%" ")
			if Shared_wizard_environment.output_level = Output_none then
				Result.append (" /nologo ")
			end
			Result.append (shared_wizard_environment.idl_file_name)
		end

	Linker_command_line: STRING is
			-- Link command line
		local
			a_string: STRING
		do
			Result := clone (Common_linker_options)
			if Shared_wizard_environment.output_level = Output_none then
				Result.append (" /nologo ")
			end
			Result.append (" /out:")
			Result.append ("%"")
			Result.append (Proxy_stub_file_name)
			Result.append ("%"")
			Result.append (" /def:")
			Result.append ("%"")
			Result.append (clone (Def_file_name))
			Result.append ("%"")
			a_string := clone (shared_wizard_environment.destination_folder)
			a_string.append (c_to_obj (Generated_iid_file_name))
			Result.append (" ")
			Result.append ("%"")
			Result.append (a_string)
			Result.append ("%"")
			a_string := clone (shared_wizard_environment.destination_folder)
			a_string.append_character (Directory_separator)
			a_string.append (c_to_obj (Generated_ps_file_name))
			Result.append (" ")
			Result.append ("%"")
			Result.append (a_string)
			Result.append ("%"")
			a_string := clone (shared_wizard_environment.destination_folder)
			a_string.append (c_to_obj (Generated_dlldata_file_name))
			Result.append (" ")
			Result.append ("%"")
			Result.append (a_string)
			Result.append ("%" %"")
			Result.append (Rpc_library)
			Result.append ("%"")
		end

end -- class WIZARD_IDL_COMPILER