indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	WIZARD_COMPILER

inherit
	WIZARD_C_COMPILER

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
			{ANY} client
			{ANY} server
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

	WIZARD_SHARED_FILE_NAMES
		export
			{NONE} all
		end

	WIZARD_ERRORS
		export
			{NONE} all
		end

feature -- Access

	ace_file_generated: BOOLEAN
			-- Was generated project ace file generated?

	resource_file_generated: BOOLEAN
			-- Was generated project resource file generated?

	makefile_generated: BOOLEAN
			-- Were Makefiles generated?

feature -- Basic Operations

	eiffel_compilation_successful (a_folder: STRING): BOOLEAN is
			-- Was Eiffel precompilation in `a_folder' successful?
		require
			non_void_folder: a_folder /= Void
			valid_folder: not a_folder.is_empty
		local
			a_local_folder: STRING
		do
			a_local_folder := environment.destination_folder.twin
			a_local_folder.append (a_folder)
			-- The ".epr" file is in the Eifgen folder for a precompiled system
			Result := has_directory_epr (a_local_folder)
			if not Result then
				if 
					a_folder.is_equal (Client) or
					component_empty (a_folder)
				then
					a_local_folder.append_character (Directory_separator)
					a_local_folder.append (Eifgen)
					Result := has_directory_epr (a_local_folder)
				end
			end
		end

	has_directory_epr (a_directory_name: STRING): BOOLEAN is
			-- Does directory have epr file?
		local
			a_directory: DIRECTORY
			a_file_list: LIST [STRING]
			list_item: STRING
		do
			create a_directory.make (a_directory_name)
			if a_directory.exists then
				from
					a_file_list := a_directory.linear_representation
					a_file_list.start
				until
					a_file_list.after or Result
				loop
					list_item := a_file_list.item
					Result := (list_item.substring 
							(list_item.count - Eiffel_project_extension.count + 1, 
							list_item.count)).is_equal (Eiffel_project_extension)
					a_file_list.forth
				end
			end
		end
		
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
			-- Set `environment.type_library_file_name' with
			-- resulting type library file name.
		local
			l_text: STRING
			l_process_launcher: WEL_PROCESS_LAUNCHER
		do
			l_text := Idl_compiler.twin
			l_text.append (" ")
			l_text.append (Idl_compiler_command_line)
			message_output.add_message (l_text)

			l_text := environment.destination_folder.twin
			l_text.append (environment.project_name)
			l_text.append (".tlb")
			environment.set_type_library_file_name (l_text)

			Env.change_working_directory (environment.destination_folder)
			generate_command_line_file (Idl_compiler_command_line, Temporary_input_file_name)
			if not environment.abort then
				l_text := Idl_compiler.twin
				l_text.append (" ")
				l_text.append (last_make_command)
				create l_process_launcher
				l_process_launcher.run_hidden
				l_process_launcher.launch (l_text, environment.destination_folder, agent message_output.add_text)
				if not l_process_launcher.last_launch_successful then
					environment.set_abort (Idl_compilation_failed)
				end
			end
		end

	compile_iid is
			-- Compile iid C file.
		do
			if (create {RAW_FILE}.make (Generated_iid_file_name)).exists then
				compile_file (Generated_iid_file_name)
			end
		end
	
	compile_ps is
			-- Compile proxy/stub C file.
		do
			if (create {RAW_FILE}.make (Generated_ps_file_name)).exists then
				compile_file (Generated_ps_file_name)
			end
		end

	compile_data is
			-- Compile dlldata C file.
		do
			if (create {RAW_FILE}.make (Generated_dlldata_file_name)).exists then
				compile_file (Generated_dlldata_file_name)
			end
		end
	
	link is
			-- Create proxy/stub dll.
		local
			l_string: STRING
			l_process_launcher: WEL_PROCESS_LAUNCHER
		do
			generate_def_file
			l_string := linker.twin
			l_string.append (" ")
			l_string.append (linker_command_line)
			message_output.add_message (l_string)
			generate_command_line_file (Linker_command_line, Temporary_input_file_name)
			if not environment.abort then
				l_string := Linker.twin
				l_string.append (" ")
				l_string.append (last_make_command)
				create l_process_launcher
				l_process_launcher.run_hidden
				l_process_launcher.launch (l_string, environment.destination_folder, agent message_output.add_text)
				if not l_process_launcher.last_launch_successful then
					environment.set_abort (Link_failed)
				else
					environment.set_proxy_stub_file_name (proxy_stub_file_name)
				end
			end
		end

	component_empty (a_folder: STRING): BOOLEAN is
			-- Check whether Component directory is is_empty.
		require
			non_void_folder: a_folder /= Void
			valid_folder: a_folder.is_equal (Client) or a_folder.is_equal (Server)
		local
			a_local_folder: STRING
			a_directory: DIRECTORY
		do
			a_local_folder := a_folder.twin
			a_local_folder.append_character (Directory_separator)
			a_local_folder.append ("Component")
			create a_directory.make (a_local_folder)
			if a_directory.exists then
				Result := a_directory.is_empty
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
			l_directory: DIRECTORY
			l_local_folder, l_cmd: STRING
			l_process_launcher: WEL_PROCESS_LAUNCHER
		do
			-- Delete EIFGEN directory if exists.
			l_local_folder := a_folder.twin
			l_local_folder.append_character (Directory_separator)
			l_local_folder.append (Eifgen)
			create l_directory.make (l_local_folder)
			if l_directory.exists then
				l_directory.recursive_delete
			end

			if a_folder.is_equal (Client) or component_empty (a_folder) then
				l_cmd := precompile_command
			else
				l_cmd := eiffel_compile_command
			end
			create l_process_launcher
			l_process_launcher.run_hidden
			environment.add_abort_request_action (agent l_process_launcher.terminate_process)
			l_process_launcher.launch (l_cmd, a_folder, agent message_output.add_text)
			check_finish_freezing_status (a_folder)
			environment.remove_abort_request_action
		end

	check_finish_freezing_status (a_folder: STRING) is
			-- Check whether finish_freezing was successful in `a_folder\EIFGEN\W_code'.
		require
			non_void_folder: a_folder /= Void
			valid_folder: not a_folder.is_empty
		local
			l_directory: DIRECTORY
			l_local_folder, l_file: STRING
			l_file_list: LIST [STRING]
			l_found: BOOLEAN
			l_count: INTEGER
		do
			l_local_folder := a_folder.twin
			l_local_folder.append_character (Directory_separator)
			l_local_folder.append (Eifgen)
			l_local_folder.append_character (Directory_separator)
			l_local_folder.append (W_code)
			if a_folder.is_equal (Client) or component_empty (a_folder) then
				l_local_folder.append_character (Directory_separator)
				l_local_folder.append (Ise_c_compiler_value)
			end
			create l_directory.make (l_local_folder)
			if l_directory.exists then
				from
					l_file_list := l_directory.linear_representation
					l_file_list.start
				until
					l_file_list.after or l_found
				loop
					l_file := l_file_list.item
					l_count := l_file.count
					l_found := l_count > 3 and then (l_file.substring_index (".exe", l_count - 3) = l_count - 3 or l_file.substring_index (".dll", l_count - 3) = l_count - 3)
					l_file_list.forth
				end
			end
			if not l_found then
				environment.set_abort (Eiffel_compilation_error)
			end
		end

	register_ps is
			-- Register generated proxy stub.
		local
			l_string: STRING
			l_process_launcher: WEL_PROCESS_LAUNCHER
		do
			l_string := "regsvr32 /s "
			l_string.append (environment.proxy_stub_file_name)
			create l_process_launcher
			l_process_launcher.run_hidden
			l_process_launcher.launch (l_string, environment.destination_folder, agent message_output.add_text)
		end
		
feature {NONE} -- Implementation

	proxy_stub_file_name: STRING is
			-- Proxy/Stub fil name
		once
			Result := environment.destination_folder.twin
			Result.append (environment.project_name)
			Result.append ("_ps.dll")
		end

	generate_def_file is
			-- Generate standard COM def file in current folder.
		local
			l_file: PLAIN_TEXT_FILE
		do
			Env.change_working_directory (environment.destination_folder)
			create l_file.make (Def_file_name)
			if not l_file.exists then
				l_file.make_create_read_write (Def_file_name)
				l_file.put_string ("DESCRIPTION %"EiffelCOM Generated Component%"%N")
				l_file.put_string ("EXPORTS%N")
				l_file.put_string ("%TDllGetClassObject%T%T@1 PRIVATE%N")
				l_file.put_string ("%TDllCanUnloadNow%T%T%T@2 PRIVATE%N")
				l_file.put_string ("%TDllRegisterServer%T%T@3 PRIVATE%N")
				l_file.put_string ("%TDllUnregisterServer%T@4 PRIVATE%N")
				l_file.close
			end
		end

	Idl_compiler_command_line: STRING is
			-- MIDL command line
		local
			l_dest: STRING
		do
			Result := Common_idl_compiler_options.twin
			Result.append (" %"")
			Result.append (environment.idl_file_name)
			Result.append ("%" /h %"")
			Result.append (Generated_header_file_name)
			Result.append ("%" /dlldata %"")
			Result.append (Generated_dlldata_file_name)
			Result.append ("%" /iid %"")
			Result.append (Generated_iid_file_name)
			Result.append ("%" /proxy %"")
			Result.append (Generated_ps_file_name)
			Result.append ("%" /tlb %"")
			Result.append (environment.project_name.twin)
			Result.append (".tlb%" /nologo ")
			Result.append (" /out %"")
			l_dest := environment.destination_folder.twin
			l_dest.keep_head (l_dest.count - 1)
			Result.append (l_dest)
			Result.append ("%"")
		end

	Linker_command_line: STRING is
			-- Link command line
		local
			l_string: STRING
		do
			Result := Common_linker_options.twin
			Result.append (" /nologo ")
			Result.append (" /out:%"")
			Result.append (Proxy_stub_file_name)
			Result.append ("%"")
			if (create {RAW_FILE}.make (environment.destination_folder + Generated_dlldata_file_name)).exists then
				Result.append (" /def:%"")
				Result.append (Def_file_name.twin)
				Result.append ("%"")
			end
			if (create {RAW_FILE}.make (environment.destination_folder + Generated_iid_file_name)).exists then
				l_string := environment.destination_folder.twin
				l_string.append (c_to_obj (Generated_iid_file_name))
				Result.append (" %"")
				Result.append (l_string)
				Result.append ("%"")
			end
			if (create {RAW_FILE}.make (environment.destination_folder + Generated_ps_file_name)).exists then
				l_string := environment.destination_folder.twin
				l_string.append_character (Directory_separator)
				l_string.append (c_to_obj (Generated_ps_file_name))
				Result.append (" %"")
				Result.append (l_string)
				Result.append ("%"")
			end
			if (create {RAW_FILE}.make (environment.destination_folder + Generated_dlldata_file_name)).exists then
				l_string := environment.destination_folder.twin
				l_string.append (c_to_obj (Generated_dlldata_file_name))
				Result.append (" %"")
				Result.append (l_string)
				Result.append ("%"")
			end
			Result.append (" ")
			Result.append (Rpc_library)
		end

	precompile_command: STRING is
			-- Eiffel compiler command line to precompile
		do
			create Result.make (100)
			Result.append (eiffel_compiler)
			Result.append (" -precompile -c_compile -batch -ace ")
			Result.append (environment.workbench_ace_file_name)
		end

	eiffel_compile_command: STRING is
			-- Eiffel compiler command line to freeze
		do
			create Result.make (100)
			Result.append (eiffel_compiler)
			Result.append (" -batch -c_compile -ace ")
			Result.append (environment.workbench_ace_file_name)
		end
			
	user_def_file_name: STRING is
			-- ".def" file name used for DLL compilation
		do
			Result := environment.project_name.twin
			Result.append (Def_file_extension)
		end
	
	Def_file_extension: STRING is ".def"
			-- DLL definition file extension

	Executable_extension: STRING is ".exe"
			-- Executable file extension

	Eiffel_project_extension: STRING is ".epr"
			-- Eiffel project extension

	Precompile_name: STRING is "precomp.epr"
			-- Precompilation project name

	Finish_freezing_command: STRING is 
			-- Finish freezing command line
		do
			create Result.make (100)
			Result.append (Eiffel_installation_dir_name + "\studio\spec\windows\bin\finish_freezing -silent")
		end

	Eifgen: STRING is "EIFGEN"
			-- Eifgen folder name

	W_code: STRING is "W_code"
			-- W_code folder name

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

	Visible: STRING is "visible";
			-- Lace `visible' keyword

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class WIZARD_COMPILER

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

