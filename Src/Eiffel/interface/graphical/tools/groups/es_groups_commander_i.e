note
	description: "[
		Commander interface for interacting with the Errors and Warnings tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	ES_GROUPS_COMMANDER_I

inherit
	USABLE_I

feature -- Basic operations

	highlight_stone (a_stone: !STONE)
			-- Attempts to highlight a given stone in the groups tree.
		require
			is_interface_usable: is_interface_usable
			a_stone_is_stone_usable: {rl_stonable: ES_STONABLE_I} Current implies rl_stonable.is_stone_usable (a_stone)
		deferred
		ensure
--			a_stone_set:  {el_stonable: ES_STONABLE_I} Current implies el_stonable.stone ~ a_stone
		end

	highlight_editor_stone
			-- Attempts to highlight a stone in the groups tree using an editor as its stone context.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
