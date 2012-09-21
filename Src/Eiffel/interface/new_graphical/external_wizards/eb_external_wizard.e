note
	description	: "Command to execute an external wizard"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_EXTERNAL_WIZARD

inherit
	ANY

	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

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
			-- Execute the wizard
		local
			temp_filename: FILE_NAME_32
			temp_file: PLAIN_TEXT_FILE_32
			wizard_launched: BOOLEAN
		do
			create temp_filename.make_temporary_name
			create temp_file.make (temp_filename)
			temp_file.open_write
			temp_file.put_string ("Success=%"<SUCCESS>%"%N")
			if Additional_parameters /= Void then
				temp_file.put_string (Additional_parameters)
			end
			temp_file.close

			launch_wizard (temp_filename)
			wizard_launched := True
		rescue
			if error_messages.is_empty then
				set_error_message ("Unable to create the temporary file required to launch the wizard")
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

	launch_wizard (callback_filename: STRING_32)
			-- Launch the wizard using the file `callback_filename' as callback.
		local
			wizard_exec_filename: FILE_NAME_32
			wizard_exec_file: RAW_FILE_32
			wizard_command: STRING_32
		do
			create wizard_exec_filename.make_from_string (location)
			wizard_exec_filename.extend ("spec")
			wizard_exec_filename.extend (eiffel_layout.eiffel_platform)
			wizard_exec_filename.set_file_name ("wizard")
			if not eiffel_layout.Executable_suffix.is_empty then
				wizard_exec_filename.add_extension (eiffel_layout.Executable_suffix)
			end

			create wizard_exec_file.make (wizard_exec_filename)
			if not (wizard_exec_file.exists and then wizard_exec_file.is_executable) then
				set_error_message (Warning_messages.w_Unable_to_execute_wizard (wizard_exec_filename))
				(create {EXCEPTIONS}).raise (Interface_names.Workbench_name+" Exception")
			end

			create wizard_command.make_empty
			wizard_command.append_string (wizard_exec_filename)
			wizard_command.append_character (' ')
			wizard_command.append_character ('"')
			wizard_command.append_string (location)
			wizard_command.append_character ('"')
			wizard_command.append_character (' ')
			wizard_command.append_string (locale.info.id.name)
			wizard_command.append_string ({STRING_32} " -callback %"")
			wizard_command.append_string (callback_filename)
			wizard_command.append_character ('"')
			launch (wizard_command)
			wait_for_finish (callback_filename)
		end

	wait_for_finish (callback_filename: STRING_32)
			-- Wait for the end of the Wizard, and collect the results.
		local
			retry_count: INTEGER
			finished: BOOLEAN
			callback_file: PLAIN_TEXT_FILE_32
			analysed_line: TUPLE[name: STRING_32; value: STRING_32]
		do
			from
				create callback_file.make (callback_filename)
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
						analysed_line := analyse_line (callback_file.last_string)
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

	adjust_string (a_string: STRING): STRING
			-- Remove any blank character and quote at beginning and
			-- and of the string.
		do
			Result := a_string.twin

			Result.left_adjust
			Result.right_adjust
			if (Result @ 1) = '"' then
				Result.keep_tail (Result.count - 1)
				Result.keep_head (Result.count - 1)
			end
			Result.left_adjust
			Result.right_adjust
		end

feature {NONE} -- Private attributes

	location: DIRECTORY_NAME_32;
			-- Location of this wizard.

note
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

end -- class EB_EXTERNAL_WIZARD
