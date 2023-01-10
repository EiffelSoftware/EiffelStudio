note
	description: "[
		Parses arguments to launch xebra_deployer.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"
class
	XD_ARGUMENT_PARSER

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

	install_dir: STRING
			-- The path of install directory
		require
			is_successful: is_successful
		do
			Result := value
		ensure
			not_result_is_detached_or_empty: Result /= Void and then not Result.is_empty
		end

feature {NONE} -- Access: Usage

	name: STRING = "Xebra Deploy Replacer"
			-- <Precursor>

	non_switched_argument_name: STRING = "install_dir"
			-- <Precursor>

	non_switched_argument_description: STRING = "The path of installed xebra files and folders"
			-- <Precursor>

	non_switched_argument_type: STRING = "folder name"
			-- <Precursor>

	version: STRING
			-- <Precursor>
		once
			Result := {XU_CONSTANTS}.Version
		end

	copyright: STRING = "Copyright Eiffel Software 2010-2023. All Rights Reserved."
			-- <Precursor>

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (2)
--			Result.extend (create {ARGUMENT_INTEGER_SWITCH}.make (debug_level_switch, "Specifies a debug level. 0: No debug output. 10: All debug ouput.", True, False, "debug_level", "The debug level (0-10)", False))
--			Result.extend (create {ARGUMENT_SWITCH}.make (clean_switch, "If set, all webapps will be cleaned", True, False))
--			Result.extend (create {ARGUMENT_SWITCH}.make (assume_webapps_are_running_switch, "If set, the server assumes that the webapps are already running and does not translate, compile and run them before connect to them.", True, False))
		end


--feature {NONE} -- Switches

--	debug_level_switch: STRING = "d|debug_level"
--	clean_switch: STRING = "c|clean"
--	assume_webapps_are_running_switch: STRING = "r|assume_webapps_are_running"

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

