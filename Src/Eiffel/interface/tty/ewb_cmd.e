note

	description: "[
			General notion of command line command
			corresponding to an option of `ec'.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class EWB_CMD

inherit
	E_CMD
		redefine
			executable
		end

	SHARED_EIFFEL_PROJECT

	SHARED_EWB_HELP

	SHARED_EWB_CMD_NAMES

	SHARED_EWB_ABBREV

	COMPARABLE
		undefine
			is_equal
		end

	SHARED_WORKBENCH

	SHARED_BATCH_NAMES

	EXCEPTIONS
		rename
			die as lic_die,
			class_name as except_class_name,
			raise as raise_exception
		export
			{NONE} all
		end

feature -- Properties

	name: STRING
		deferred
		end

	help_message: STRING_GENERAL
		deferred
		end

	abbreviation: CHARACTER
		deferred
		end

	output_window: OUTPUT_WINDOW
			-- Output for current menu selection
		do
			Result := command_line_io.output_window
		ensure
			Result = command_line_io.output_window
		end

feature {NONE} -- Error messages

	Warning_messages: WARNING_MESSAGES
			-- Placeholder to access all warning messages.
		once
			create Result
		end

feature -- Comparison

	is_less alias "<" (other: EWB_CMD): BOOLEAN
			-- The sort criteria is the command name
		do
			Result := name < other.name
		end

feature -- Status report

	executable: BOOLEAN
			-- <Precursor>
		do
			Result := workbench.is_already_compiled
		end

feature {EWB_LOOP} -- Execution

	loop_action
			-- Action performed when invoked from the
			-- command loop (ie after ec -loop).
		do
			check_arguments_and_execute
		end

feature {NONE} -- Implementation

	command_line_io: COMMAND_LINE_IO
		once
			Result := {ES}.command_line_io
		end

	arguments: STRING
			-- Arguments passed to the application
		once
			create Result.make (0)
		end

	check_arguments_and_execute
			-- Check the arguments and then perform then
			-- command line action.
		do
			if command_line_io.more_arguments then
				command_line_io.print_too_many_arguments
			end
			if not command_line_io.abort then
				if Workbench.is_already_compiled then
					execute
				else
					output_window.put_string (Warning_messages.w_Must_compile_first)
					output_window.put_new_line
				end
			else
				command_line_io.reset_abort
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
