indexing
	description: "Serialize WSDL codedom tree"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDS_WSDL_SERIALIZER

inherit
	ECDS_SERIALIZER
		rename
			make as serializer_make
		end

	ECDS_OUTPUT_TAGS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_dest_dir, a_file_title, a_wsdl_path: STRING; a_server_code: BOOLEAN) is
			-- Initialize instance.
		require
			non_void_destination_directory: a_dest_dir /= Void
			valid_destination_Directory: not a_dest_dir.is_empty
			non_void_file_title: a_file_title /= Void
			valid_file_title: not a_file_title.is_empty
			non_void_wsdl_path: a_wsdl_path /= Void
			valid_wsdl_path: not a_wsdl_path.is_empty
		do
			serializer_make (a_dest_dir, a_file_title)
			wsdl_path := a_wsdl_path
			generate_server_code := a_server_code
		ensure
			destination_directory_set: (a_dest_dir.item (a_dest_dir.count) /= '\' implies destination_directory = a_dest_dir) and
							(a_dest_dir.item (a_dest_dir.count) = '\' implies destination_directory.is_equal (a_dest_dir.substring (1, a_dest_dir.count - 1)))
			file_title_set: file_title = a_file_title
			wsdl_path_set: wsdl_path = a_wsdl_path
			generate_server_code_set: generate_server_code = a_server_code
		end

feature -- Access

	wsdl_path: STRING
			-- Path to WSDL file definition

	generate_server_code: BOOLEAN
			-- Should code for server be generated?

feature -- Basic Operation

	serialize is
			-- Serialize codedom tree.
		local
			l_key: REGISTRY_KEY
			l_value: SYSTEM_STRING
			l_path: STRING
			l_process_info: SYSTEM_DLL_PROCESS_START_INFO
			l_process: SYSTEM_DLL_PROCESS
			l_res: DIRECTORY_INFO
			l_output: STRING
		do
			text_output := Void
			if not {SYSTEM_DIRECTORY}.exists (destination_directory) then
				l_res := {SYSTEM_DIRECTORY}.create_directory (destination_directory)
			end
			l_key := {REGISTRY}.local_machine.open_sub_key ("SOFTWARE\Microsoft\.NETFramework")
			last_serialization_successful := False
			if l_key /= Void then
				l_value ?= l_key.get_value ("sdkInstallRootv1.1")
				if l_value = Void then
					l_value ?= l_key.get_value ("sdkInstallRoot")
				end
			end
			if l_value /= Void then
				l_path := l_value
				l_path.append ("bin\wsdl.exe")
				if {SYSTEM_FILE}.exists (l_path) then
					create l_process_info.make (l_path, wsdl_arguments)
					l_process_info.set_working_directory (destination_directory)
					l_process_info.set_redirect_standard_output (True)
					l_process_info.set_redirect_standard_error (True)
					l_process_info.set_use_shell_execute (False)
					l_process_info.set_window_style ({SYSTEM_DLL_PROCESS_WINDOW_STYLE}.Hidden)
					l_process_info.set_create_no_window (True)
					create l_process.make
					l_process.set_start_info (l_process_info)
					last_serialization_successful := l_process.start
					if not last_serialization_successful then
						last_error_message := "Process " + l_path + " could not be started."
					else
						wait_for_file
						text_output := l_process.standard_output.read_to_end
						l_output := l_process.standard_error.read_to_end
						if l_output /= Void and then not l_output.is_empty then
							text_output.append ("%N" + l_output + "</error>")
						end
					end
				else
					last_error_message := "Could not find wsdl.exe at " + l_path
				end
			else
				last_error_message := "Could not find wsdl.exe, make sure .NET Framework SDK is installed on machine."
			end
		end

	wsdl_arguments: STRING is
			-- Arguments to be passed to `wsdl.exe'
		do
			Result := "/language:%"" + (create {ECDS_PROVIDER}).get_type.assembly_qualified_name
			if generate_server_code then
				Result.append ("%" /server %"")
			else
				Result.append ("%" %"")
			end
			Result.append (wsdl_path)
			Result.append_character ('"')
		ensure
			non_void_arguments: Result /= Void
		end

	File_extension: STRING is ".ecdw"
			-- Serialized codedom tree file extension

end -- class ECDS_WSDL_SERIALIZER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Serializer
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
