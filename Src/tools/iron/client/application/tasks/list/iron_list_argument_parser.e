note
	description: "[
			Summary description for {IRON_LIST_ARGUMENT_PARSER}.
						
				iron list 						: List of available packages, i.e. packages that have been installed
												: as well as packages available from the Iron server.
				iron list --installed 			: List of installed packages.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_LIST_ARGUMENT_PARSER

inherit
	ARGUMENT_BASE_PARSER
		rename
			make as make_parser
		end

	IRON_LIST_ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make (a_task: IRON_TASK)
			-- Initialize argument parser
		do
			task := a_task
			make_parser (False, False, False)
			set_argument_source (a_task.argument_source)
--			set_is_using_separated_switch_values (False)
--			set_non_switched_argument_validator (create {ARGUMENT_DIRECTORY_VALIDATOR})
		end

	task: IRON_TASK

feature -- Access

	only_installed: BOOLEAN
		once
			Result := has_option (installed_switch)
		end

feature {NONE} -- Usage

--	non_switched_argument_name: IMMUTABLE_STRING_32
--		once
--			create Result.make_from_string ({STRING_32} "")
--		end

--	non_switched_argument_description: IMMUTABLE_STRING_32
--			--  <Precursor>
--		once
--			create Result.make_from_string ({STRING_32} "")
--		end

--	non_switched_argument_type: IMMUTABLE_STRING_32
--			--  <Precursor>
--		once
--			create Result.make_from_string ({STRING_32} "")
--		end

	name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ({IRON_CONSTANTS}.executable_name + " " + task.name)
		end

feature {NONE} -- Switches

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (12)
			Result.extend (create {ARGUMENT_SWITCH}.make (installed_switch, "Only installed packages", True, False))
			add_verbose_switch (Result)
		end

	installed_switch: STRING = "i|installed"

;note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
