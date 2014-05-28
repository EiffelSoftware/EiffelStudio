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
	IRON_ARGUMENT_BASE_PARSER

	IRON_LIST_ARGUMENTS

create
	make

feature -- Access

	only_installed: BOOLEAN
		once
			Result := has_option (installed_switch)
		end

	only_conflicts: BOOLEAN
		once
			Result := has_option (conflict_switch)
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

feature {NONE} -- Switches

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (5)
			Result.extend (create {ARGUMENT_SWITCH}.make (installed_switch, "Only installed packages", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (conflict_switch, "Only conflict packages ", True, False))
			fill_argument_switches (Result)
		end

	installed_switch: STRING = "i|installed"
	conflict_switch: STRING = "c|conflict"

;note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
