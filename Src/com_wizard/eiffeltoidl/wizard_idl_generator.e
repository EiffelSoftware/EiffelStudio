indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_IDL_GENERATOR

inherit
	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_PROCESS_LAUNCHER
		export
			{NONE} all
		redefine
			launch
		end

create
	make

feature -- Access

	destination_folder: STRING

feature -- Basic operations

	generate is
			-- Generate IDL file
		local
			folder: DIRECTORY
			command: STRING
			input_data: EI_CLASS_DATA_INPUT
			raw_file, idl_file: PLAIN_TEXT_FILE
			midl_library: EI_MIDL_LIBRARY
			midl_coclass_creator: EI_MIDL_COCLASS_CREATOR
		do
			message_output.add_message (Current, "Processing Eiffel class")

			destination_folder := clone (shared_wizard_environment.destination_folder)

			destination_folder.append ("idl")

			create folder.make (destination_folder)

			if not folder.exists then
				folder.create_dir
			end

			create command.make (100)
			command.append (eiffel_compiler + " -flatshort -filter com ")
			command.append (shared_wizard_environment.eiffel_class_name)
			command.append (" -project ")
			command.append (shared_wizard_environment.eiffel_project_name)

			launch (command, destination_folder)

			create raw_file.make (raw_file_name)

			create input_data.make
			input_data.input_from_file (raw_file)

			if input_data.class_not_found then
				message_output.add_message (Current, "Error: Class not in project")
				Shared_wizard_environment.set_abort (Idl_generation_error)
			else
				if not shared_wizard_environment.abort then
					message_output.add_message (Current, "Generating IDL file")
					
					create midl_library.make (shared_wizard_environment.eiffel_class_name)
					create midl_coclass_creator.make
					midl_coclass_creator.create_from_eiffel_class (input_data.eiffel_class)
					midl_library.set_coclass (midl_coclass_creator.midl_coclass)

					create idl_file.make_open_write (shared_wizard_environment.idl_file_name)
					idl_file.put_string (midl_library.code)
					idl_file.flush
					idl_file.close
				end
			end
		rescue
			message_output.add_message (Current, "Error: Class not in project")
			Shared_wizard_environment.set_abort (Idl_generation_error)
		end

feature {NONE} -- Basic operations

	launch (a_command_line, a_working_directory: STRING) is
			-- Launch process described in `a_command_line' from `a_working_directory'.
			-- Wait for end of process and write output to `output_message'.
		local
			a_string: STRING
			a_boolean: BOOLEAN
			an_integer: INTEGER
			a_last_process_result: INTEGER
			a_output: STRING
			output_file: PLAIN_TEXT_FILE
		do
			if not (a_command_line.item (1) = '"') then
				a_command_line.prepend ("%"")
			end
			if not (a_command_line.item (a_command_line.count) = '"') then
				a_command_line.append ("%"")
			end
			a_string := clone (Console_spawn_application)
			a_string.append (" ")
			a_string.append (a_command_line)
			spawn (a_string, a_working_directory)
			output_pipe.close_input
			from
				output_pipe.read_stream (Block_size)
				create a_output.make (100)
			until
				not output_pipe.last_read_successful or Shared_wizard_environment.abort
			loop
				a_output.append (output_pipe.last_string)

				output_pipe.read_stream (Block_size)
			end
			a_output.replace_substring_all ("%R%N", "%N")

			create output_file.make_open_write (raw_file_name)
			output_file.put_string (a_output)
			output_file.close

			if not Shared_wizard_environment.abort then
				an_integer := cwin_wait_for_single_object (process_info.process_handle, cwin_infinite)
				check
					valid_external_call: an_integer = cwin_wait_object_0
				end
				a_boolean := cwin_exit_code_process (process_info.process_handle, $a_last_process_result)
				check
					valid_external_call: a_boolean
				end
			end
			cwin_close_handle (process_info.process_handle)
			output_pipe.close_output
			input_pipe.close_input
			input_pipe.close_output
			last_process_result := a_last_process_result
		rescue
			Shared_wizard_environment.set_abort (Idl_generation_error)
		end

	raw_file_name: STRING is
			-- Intermediate file for IDL generator.
		once
			Result := clone (shared_wizard_environment.destination_folder)
			Result.append ("idl\e2idl.output")
	
		end

end -- class WIZARD_IDL_GENERATOR
