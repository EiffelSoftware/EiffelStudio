class
	WIZARD_COMPILER

inherit
	WIZARD_C_COMPILER

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_PROCESS_LAUNCHER
		rename
			message_output as process_launcher_message_output
		export
			{NONE} all
		end

	WIZARD_RESCUABLE
		export
			{NONE} all
		end
	
	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

	WIZARD_FILE_SYSTEM_MANAGEMENT
		export
			{NONE} all
		end

create
	make

feature -- Access

	eiffel_compilation_successful (a_folder: STRING): BOOLEAN is
			-- Was Eiffel precompilation in `a_folder' successful?
		require
			non_void_folder: a_folder /= Void
			valid_folder: not a_folder.empty
		local
			a_directory: DIRECTORY
			a_local_folder: STRING
			a_file_list: LIST [STRING]
		do
			a_local_folder := clone (Shared_wizard_environment.destination_folder)
			a_local_folder.append (a_folder)
			-- The ".epr" file is in the Eifgen folder for a precompiled system
			if 
				a_folder.is_equal (Client) or
				component_empty (a_folder)
			then
				a_local_folder.append_character (Directory_separator)
				a_local_folder.append (Eifgen)
			end
			create a_directory.make (a_local_folder)
			if a_directory.exists then
				from
					a_file_list := a_directory.linear_representation
					a_file_list.start
				until
					a_file_list.after or Result
				loop
					Result := (a_file_list.item.substring (a_file_list.item.count + 1 - Eiffel_project_extension.count, a_file_list.item.count)).is_equal (Eiffel_project_extension)
					a_file_list.forth
				end
			end
		end

	ace_file_generated: BOOLEAN
			-- Was generated project ace file generated?

	resource_file_generated: BOOLEAN
			-- Was generated project resource file generated?

	makefile_generated: BOOLEAN
			-- Were Makefiles generated?

feature -- Basic Operations

	set_makefile_generated (a_boolean: BOOLEAN) is
			-- Set `makefile_generated'.
		do
			makefile_generated := a_boolean
		end

	set_ace_file_generated (a_boolean: BOOLEAN) is
			-- Set `ace_file_generated'.
		do
			ace_file_generated := a_boolean
		end

	set_resource_file_generated (a_boolean: BOOLEAN) is
			-- Set `resource_file_generated'.
		do
			resource_file_generated := a_boolean
		end

	compile_idl is
			-- Compile idl file pointed by `idl_file_name'.
			-- Set `shared_wizard_environment.type_library_file_name' with
			-- resulting type library file name.
		local
			a_string: STRING
		do
			a_string := clone (Idl_compiler)
			a_string.append (Space)
			a_string.append (Idl_compiler_command_line)
			message_output.add_message (Current, a_string)

			a_string := clone (Shared_wizard_environment.destination_folder)
			a_string.append (shared_wizard_environment.project_name)
			a_string.append (".tlb")
			shared_wizard_environment.set_type_library_file_name (a_string)

			execution_environment.change_working_directory (Shared_wizard_environment.destination_folder)
			generate_command_line_file (Idl_compiler_command_line, Temporary_input_file_name)
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
			message_output.add_message (Current, a_string)
			generate_command_line_file (Linker_command_line, Temporary_input_file_name)
			a_string := clone (Linker)
			a_string.append (Space)
			a_string.append (last_make_command)
			launch (a_string, shared_wizard_environment.destination_folder)
			check_return_code
			shared_wizard_environment.set_proxy_stub_file_name (proxy_stub_file_name)
		end

	component_empty (a_folder: STRING): BOOLEAN is
			-- Check whether Component directory is empty.
		require
			non_void_folder: a_folder /= Void
			valid_folder: a_folder.is_equal (Client) or a_folder.is_equal (Server)
		local
			a_local_folder: STRING
			a_directory: DIRECTORY
		do
			a_local_folder := clone (a_folder)
			a_local_folder.append_character (Directory_separator)
			a_local_folder.append ("Component")
			create a_directory.make (a_local_folder)
			if a_directory.exists then
				Result := a_directory.empty
			end
		end
		
	compile_eiffel (a_folder: STRING) is
			-- Compile Eiffel code in `a_folder'.
		require
			non_void_folder: a_folder /= Void
			valid_folder: a_folder.is_equal (Client) or a_folder.is_equal (Server)
			ace_file_generated: ace_file_generated
			resource_file_generated: resource_file_generated			
		local
			displayed: BOOLEAN
			a_directory: DIRECTORY
			a_local_folder: STRING
			a_project_file, a_dest_file: STRING
		do
			-- Delete EIFGEN directory if exists.
			a_local_folder := clone (a_folder)
			a_local_folder.append_character (Directory_separator)
			a_local_folder.append (Eifgen)
			create a_directory.make (a_local_folder)
			if a_directory.exists then
				a_directory.recursive_delete
			end

			displayed := displayed_while_running
			set_displayed_while_running (True)
			if 
				a_folder.is_equal (Client) or
				component_empty (a_folder)
			then
				launch (precompile_command, a_folder)
			else
				launch (eiffel_compile_command, a_folder)
			end
			if eiffel_compilation_successful (a_folder) then
				a_local_folder := clone (a_folder)
				a_local_folder.append_character (Directory_separator)
				a_local_folder.append (Eifgen)
				a_local_folder.append_character (Directory_separator)
				a_local_folder.append (W_code)
				launch (finish_freezing_command, a_local_folder)
				check_finish_freezing_status (a_folder)
				if 
					not Shared_wizard_environment.abort and
					not Shared_wizard_environment.not_spawn_ebench
				then
					if a_folder.is_equal (Client) then
						a_dest_file := clone (a_folder)
						a_dest_file.append_character (Directory_separator)
						a_project_file := clone (a_dest_file)
						a_dest_file.append (Precompile_name)
						a_project_file.append (Eifgen)
						a_project_file.append_character (Directory_separator)
						a_project_file.append (Precompile_name)
						file_copy (a_project_file, a_dest_file)
					end
					spawn (eiffel_bench_command (a_folder), a_local_folder)
				end
			else
				shared_wizard_environment.set_abort (Eiffel_compilation_error)
			end		
			set_displayed_while_running (displayed)				
		end

	check_finish_freezing_status (a_folder: STRING) is
			-- Check whether finish_freezing was successful in `a_folder\EIFGEN\W_code'.
		require
			non_void_folder: a_folder /= Void
			valid_folder: not a_folder.empty
		local
			a_directory: DIRECTORY
			a_local_folder: STRING
			a_file_list: LIST [STRING]
			found: BOOLEAN
		do
			a_local_folder := clone (a_folder)
			a_local_folder.append_character (Directory_separator)
			a_local_folder.append (Eifgen)
			a_local_folder.append_character (Directory_separator)
			a_local_folder.append (W_code)
			if a_folder.is_equal (Client) then
				a_local_folder.append_character (Directory_separator)
				a_local_folder.append (Msc)
			end
			create a_directory.make (a_local_folder)
			if a_directory.exists then
				from
					a_file_list := a_directory.linear_representation
					a_file_list.start
				until
					a_file_list.after or found
				loop
					found := (a_file_list.item.substring (a_file_list.item.count + 1 - Executable_extension.count, a_file_list.item.count)).is_equal (Executable_extension)
					a_file_list.forth
				end
			end
			if not found then
				Shared_wizard_environment.set_abort (Eiffel_compilation_error)
			end
		end

	register_ps is
			-- Register generated proxy stub.
		local
			a_string: STRING
		do
			a_string := "regsvr32 /s "
			a_string.append (Shared_wizard_environment.proxy_stub_file_name)
			launch (a_string, Shared_wizard_environment.destination_folder)
		end

feature {NONE} -- Implementation

	proxy_stub_file_name: STRING is
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
			execution_environment.change_working_directory (shared_wizard_environment.destination_folder)
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
			if Shared_wizard_environment.output_level = message_output.Output_none then
				Result.append (" /nologo ")
			end
			
			Result.append (Double_quote)
			Result.append (shared_wizard_environment.idl_file_name)
			Result.append (Double_quote)
		end

	Linker_command_line: STRING is
			-- Link command line
		local
			a_string: STRING
		do
			Result := clone (Common_linker_options)
			if Shared_wizard_environment.output_level = message_output.Output_none then
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
			Result.append ("%" ")
			Result.append (Rpc_library)
		end

	precompile_command: STRING is
			-- Eiffel compiler command line to precompile
		do
			create Result.make (100)
			Result.append (eiffel_compiler)
			Result.append (" -precompile -batch -ace ")
			Result.append (Ace_file_name)
		end

	eiffel_compile_command: STRING is
			-- Eiffel compiler command line to freeze
		do
			create Result.make (100)
			Result.append (eiffel_compiler)
			Result.append (" -batch -ace ")
			Result.append (Ace_file_name)
		end

	eiffel_bench_command (a_folder: STRING): STRING is
			-- Launch EiffelBench with first project in `a_folder'
		require
			non_void_folder: a_folder /= Void
			valid_folder: not a_folder.empty
			--contains_eiffel_project: a_folder has one and only one '.epr' file.
		local
			a_directory: DIRECTORY
			a_file_list: LIST [STRING]
			found: BOOLEAN
		do
			Result := "ebench "
			Result.append (Shared_wizard_environment.destination_folder)
			Result.append (a_folder)
			Result.append_character (Directory_separator)
			create a_directory.make (a_folder)
			if a_directory.exists then
				from
					a_file_list := a_directory.linear_representation
					a_file_list.start
				until
					a_file_list.after or found
				loop
					found := a_file_list.item.substring (a_file_list.item.count + 1 - Eiffel_project_extension.count, a_file_list.item.count).is_equal (Eiffel_project_extension)
					if found then
						Result.append (a_file_list.item)
					end
					a_file_list.forth
				end
			end
		end
			
	user_def_file_name: STRING is
			-- ".def" file name used for DLL compilation
		do
			Result := clone (Shared_wizard_environment.project_name)
			Result.append (Def_file_extension)
		end
	
	Def_file_extension: STRING is ".def"
			-- DLL definition file extension

	Executable_extension: STRING is ".exe"
			-- Executable file extension

	Ace_file_name: STRING is "Ace.ace"
			-- Ace file name

	Eiffel_project_extension: STRING is ".epr"
			-- Eiffel project extension

	Precompile_name: STRING is "precomp.epr"
			-- Precompilation project name

	Finish_freezing_command: STRING is "finish_freezing -silent"
			-- Finish freezing command line

	Eifgen: STRING is "EIFGEN"
			-- Eifgen folder name

	W_code: STRING is "W_code"
			-- W_code folder name

	Msc: STRING is "msc"
			-- precompilation driver.exe folder name

	Driver_executable: STRING is "driver.exe"
			-- Precompilation driver executable
	
	Shared_library_option: STRING is
			-- Dll definition file for Ace file
		do
			Result := "default%N%Tshared_library_definition (%""
			Result.append (User_def_file_name)
			Result.append ("%")")
		end

	Stdcall: STRING is "__stdcall"
			-- Dll function calling convention

	Call_type: STRING is "call_type"
			-- DLL Defintion type call_type option

	Visible: STRING is "visible"
			-- Lace `visible' keyword

end -- class WIZARD_COMPILER
