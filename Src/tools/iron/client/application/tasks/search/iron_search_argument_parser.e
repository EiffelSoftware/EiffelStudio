note
	description: "[
			Summary description for {IRON_SEARCH_ARGUMENT_PARSER}.

		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_SEARCH_ARGUMENT_PARSER

inherit
	IRON_ARGUMENT_MULTI_PARSER

	IRON_SEARCH_ARGUMENTS

create
	make

feature -- Access

	resources: LIST [IMMUTABLE_STRING_32]
		once
			create {ARRAYED_LIST [IMMUTABLE_STRING_32]} Result.make (values.count)
			across
				values as c
			loop
				Result.force (create {IMMUTABLE_STRING_32}.make_from_string (c.item))
			end
		end

feature {NONE} -- Usage

	non_switched_argument_name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string ({STRING_32} "package id or uri or name")
		end

	non_switched_argument_description: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "Package id or full url or name")
		end

	non_switched_argument_type: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "string")
		end

feature {NONE} -- Switches

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (1)
			fill_argument_switches (Result)
		end

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
