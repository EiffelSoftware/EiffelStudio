note
	description: "[
		Parses arguments to launch a webapp.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_ARGUMENT_PARSER

inherit
	ARGUMENT_SINGLE_PARSER
		rename
			make as make_single_parser
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize the argument parser.
		do
			make_single_parser (False, True)
			set_non_switched_argument_validator (create {ARGUMENT_FILE_VALIDATOR})
			set_is_showing_argument_usage_inline (False)
		end

feature -- Access

	config_filename: STRING
			-- The path of the config file
		require
			is_successful: is_successful
		do
			Result := value
		ensure
			not_result_is_detached_or_empty: Result /= Void and then not Result.is_empty
		end

	debug_level: INTEGER
			-- The debug_level
		require
			is_successful: is_successful
		do
			Result := 0
			if has_option (debug_level_switch) and then attached option_of_name (debug_level_switch) as l_option then
				if l_option.value.is_integer then
					Result := l_option.value.to_integer
				end
			end
		end

	is_interactive: BOOLEAN
		--
		require
			is_successful: is_successful
		do
			Result := has_option (interactive_switch)
		end

feature -- Status report

feature {NONE} -- Access: Usage

	name: STRING = "Xebra Web Application"
			-- <Precursor>

	non_switched_argument_name: STRING = "config_filename"
			-- <Precursor>

	non_switched_argument_description: STRING = "The path of the config file to use."
			-- <Precursor>

	non_switched_argument_type: STRING = "file name"
			-- <Precursor>

	version: STRING
			-- <Precursor>
		once
			Result := {XU_CONSTANTS}.Version
		end

	copyright: STRING = "Copyright Eiffel Software 2009-2022. All Rights Reserved."
			-- <Precursor>

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (1)
			Result.extend (create {ARGUMENT_INTEGER_SWITCH}.make
			 (debug_level_switch, "Specifies a debug level.%N%T1: Start and stop of overall application" +
														  "%N%T2: Application configuration" +
														  "%N%T3: Start and stop of main components" +
														  "%N%T4: Information about tasks that are performed" +
														  "%N%T5: Information about subtasks that are performed" +
														  "%N%T6: Very verbose information about subtasks that are performed", True, False, "debug_level", "The debug level (1-6)", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (interactive_switch, "When run in interactive mode, the user can exit the application by entering 'x'.", True, False))
		end

feature {NONE} -- Switches
	debug_level_switch: STRING = "d|debug_level"
	interactive_switch: STRING = "i|interactive"
note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

