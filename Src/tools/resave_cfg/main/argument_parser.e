indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_MULTI_PARSER
		rename
			make as make_parser
		export
			{NONE} all
			{ANY} successful, execute
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize argument parser
		do
			make_parser (False, False, False)
			set_use_separated_switch_values (True)
			set_show_switch_arguments_inline (True)
			set_loose_argument_validator (create {ARGUMENT_FILE_VALIDATOR})
		end

feature -- Access

	files: LINEAR [STRING] is
			-- List of files to resave
		require
			successful: successful
		once
			Result := values
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Usage

	loose_argument_name: STRING = "ecf"
			-- Name of lose argument, used in usage information

	loose_argument_description: STRING = "An Eiffel configuration file"
			-- Description of lose argument, used in usage information

	loose_argument_type: STRING = "Eiffel configuration file"
			-- Type of lose argument, used in usage information.
			-- A type is a short description of the argument. I.E. "Configuration File"

	name: STRING = "savecfg"
			-- Full name of application

	version: STRING = "6.0"
			-- Version number of application

	switches: ARRAYED_LIST [ARGUMENT_SWITCH] is
			-- Retrieve a list of switch used for a specific application
		once
			--| No switches
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
