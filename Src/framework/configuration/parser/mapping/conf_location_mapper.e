note
	description: "[
				Global conf location mapper managing a collection of registered configuration location mappings
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LOCATION_MAPPER

create {CONF_SETTING}
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create mappings.make (0)
		end

feature -- Access

	mapped_path (a_location: READABLE_STRING_32): detachable READABLE_STRING_32
			-- Path mapped with `a_location' if any.
		local
			loc: READABLE_STRING_32
		do
			loc := a_location
			across
				mappings as c
			loop
				if attached c.mapped_location (loc) as s then
					loc := s
				end
			end
			Result := loc
		end

	expected_action (a_location: READABLE_STRING_32): detachable CONF_LOCATION_MAPPER_ACTION
			-- If Current mapping is waiting for specific action to handle `a_location', return the needed parameters ?
			--| for instance with iron, a possible action would be to install related package.
		local
			loc: READABLE_STRING_32
		do
			loc := a_location
			across
				mappings as c
			until
				Result /= Void
			loop
				if attached c.expected_action_parameters (a_location) as l_action then
					Result := l_action
				end
			end
		end

	mappings: ARRAYED_LIST [CONF_LOCATION_MAPPING]
			-- Registered location mappings.

feature -- Change

	refresh
			-- Refresh mappings.
		do
			across
				mappings as c
			loop
				c.refresh
			end
		end

	register (a_mapping: CONF_LOCATION_MAPPING)
			-- Register `a_mapping' with Current.
		do
			mappings.force (a_mapping)
		end

	unregister (a_mapping: CONF_LOCATION_MAPPING)
			-- Un-Register `a_mapping' with Current.
		do
			mappings.prune_all (a_mapping)
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
