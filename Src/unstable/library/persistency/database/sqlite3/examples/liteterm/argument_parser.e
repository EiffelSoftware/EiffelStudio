note
	description: "[
		Command line argument parser for the SQLite Terminal (LiteTerm) application.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_SINGLE_PARSER
		rename
			make as make_parser
		export
			{NONE} all
			{ANY} is_successful, execute, has_executed, system_name
		end

	ANY

create
	make

feature {NONE} -- Initialization

	make
			-- Initializes the argument parser.
		do
			make_parser (False, True)
			set_is_showing_argument_usage_inline (True)
			set_is_usage_verbose (False)
		end

feature -- Access

	file_name: IMMUTABLE_STRING_8
			-- Database file name.
		require
			is_successful: is_successful
		once
			Result := value
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
		end

feature -- Status report

	is_open_read_write: BOOLEAN
			-- Indicates if the database should be opened writable.
		require
			is_successful: is_successful
		do
			Result := has_option (write_switch) or else is_open_create_read_write
		end

	is_open_create_read_write: BOOLEAN
			-- Indicates if the database should be opened writable, and created if not existing.
		require
			is_successful: is_successful
		do
			Result := has_option (create_switch)
		end

feature {NONE} -- Usage

	name: STRING = "SQLite Terminal"
			-- <Precursor>

	version: STRING = "0.6"
			-- <Precursor>

	copyright: STRING = "Copyright Eiffel Software 2009-2021. All Rights Reserved."
			-- <Precursor>

	non_switched_argument_name: STRING = "Filename"
			-- <Precursor>

	non_switched_argument_description: STRING = "Database file name, ':memory:' for an in-memory database."
			-- <Precursor>

	non_switched_argument_type: STRING = "Database File"
			-- <Precursor>

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (2)
			Result.extend (create {ARGUMENT_SWITCH}.make (write_switch, "Opens the database in write mode.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (create_switch, "Creates the database file if it does not exist", True, False))
		end

feature {NONE} -- Switches

	write_switch: STRING = "w|open-write"
	create_switch: STRING = "c|create-if-not-exists"

;note
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
