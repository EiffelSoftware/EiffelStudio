note
	description	: "Command to execute an external wizard"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_EXTERNAL_WIZARD

inherit
	ANY

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

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	SHARED_LOCALE
		export
			{NONE} all
		end

feature -- Execution

	execute
			-- Execute the wizard.
		local
			temp_file: PLAIN_TEXT_FILE
			wizard_launched: BOOLEAN
		do
				-- Create callback file.
			create temp_file.make_open_temporary_with_prefix (eiffel_layout.temporary_path.extended ("eifwizard-").name)
				-- Fill callback file with input data.
			temp_file.put_string ("Success=%"<SUCCESS>%"%N")
			if Additional_parameters /= Void then
				temp_file.put_string (Additional_parameters)
			end
			temp_file.close
				-- Request wizard to fill callback file with output data
				-- and load the data into memory.
			launch_wizard (temp_file.path.name)
			wizard_launched := True
				-- Remove callback file.
			temp_file.delete
		rescue
			if error_messages.is_empty then
				set_error_message ("Unable to create the temporary file required to launch the wizard.")
			end
		end

	Additional_parameters: STRING
			-- Additional parameters
		deferred
		end

	result_parameters: LINKED_LIST [TUPLE [name: STRING_32; value: STRING_32]]
			-- Parameters returned by the Wizard.

	successful: BOOLEAN
			-- Was the execution of the wizard successful?

feature {NONE} -- Implementation

	launch_wizard (callback_filename: READABLE_STRING_GENERAL)
			-- Launch the wizard using the file `callback_filename' as callback.
		local
			wizard_exec_filename: PATH
			wizard_exec_file: RAW_FILE
			wizard_command: STRING_32
			f: PROCESS_FACTORY
			p: PROCESS
		do
			wizard_exec_filename := location.extended ("spec").extended (eiffel_layout.eiffel_platform).extended ("wizard" + eiffel_layout.executable_suffix)

			create wizard_exec_file.make_with_path (wizard_exec_filename)
			if not (wizard_exec_file.exists and then wizard_exec_file.is_executable) then
				set_error_message (Warning_messages.w_Unable_to_execute_wizard (wizard_exec_filename.name))
				(create {EXCEPTIONS}).raise (Interface_names.Workbench_name+" Exception")
			end

			create wizard_command.make_empty
			wizard_command.append_string (wizard_exec_filename.name)
				-- Use current directory as a source one to avoid issues with Unicode paths.
			wizard_command.append_string ({STRING_32} " . ")
			wizard_command.append_string (locale.info.id.name)
			wizard_command.append_string ({STRING_32} " -callback %"")
			wizard_command.append_string_general (callback_filename)
			wizard_command.append_character ('"')
			create f
			p := f.process_launcher_with_command_line (wizard_command, location.name)
			p.launch
			wait_for_finish (callback_filename)
			p.wait_for_exit
		end

	wait_for_finish (callback_filename: READABLE_STRING_GENERAL)
			-- Wait for the end of the Wizard, and collect the results.
		local
			retry_count: INTEGER
			finished: BOOLEAN
			callback_file: PLAIN_TEXT_FILE
			analysed_line: TUPLE[name: STRING_32; value: STRING_32]
			u: UTF_CONVERTER
		do
			from
				create callback_file.make_with_name (callback_filename)
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
					callback_file.read_line
					if not callback_file.last_string.is_empty and then callback_file.last_string.index_of ('=', 1) /= 0 then
							-- The file uses UTF-8 encoding.
						analysed_line := analyse_line (u.utf_8_string_8_to_string_32 (callback_file.last_string))
						result_parameters.extend (analysed_line)
						if analysed_line.name.is_equal ("success") and then
							not analysed_line.value.is_equal ("<SUCCESS>")
						then
							finished := True
							analysed_line.value.to_lower
							if analysed_line.value.is_equal ("yes") then
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

	wait
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

	analyse_line (a_line: STRING_32): TUPLE [name: STRING_32; value: STRING_32]
			-- Separate a line "Name=Value" into 2 elements.
			-- The first element contains the name in lower case, the second
			-- contains the value.
		local
			equal_index: INTEGER
			loc_name: STRING_32
			loc_value: STRING_32
		do
			equal_index := a_line.index_of ('=', 1)
			if equal_index /= 0 then
				loc_name := adjust_string (a_line.substring (1, equal_index - 1))
				loc_value := adjust_string (a_line.substring (equal_index + 1, a_line.count))
				loc_name.to_lower
				Result := [loc_name, loc_value]
			end
		end

	adjust_string (a_string: STRING_32): STRING_32
			-- Remove any blank character and quote at beginning and
			-- and of the string.
		do
			Result := a_string.twin

			Result.left_adjust
			Result.right_adjust
			if Result [1] = '"' then
				Result.keep_tail (Result.count - 1)
				Result.keep_head (Result.count - 1)
			end
			Result.left_adjust
			Result.right_adjust
		end

feature {NONE} -- Private attributes

	location: PATH;
			-- Location of this wizard.

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
