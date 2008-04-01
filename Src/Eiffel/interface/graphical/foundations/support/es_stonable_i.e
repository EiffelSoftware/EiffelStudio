indexing
	description: "[
		Abstract inferface for tools/UI where stones can set and synchronized.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_STONABLE_I

inherit
	USABLE_I

feature -- Access

	stone: ?STONE assign set_stone
			-- Last set stone.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Element change

	set_stone (a_stone: ?STONE)
			-- Sets last stone.
			-- Note: Be sure to call `query_set_stone', where applicable.
			--
			-- `a_stone': Stone to set.
		require
			is_interface_usable: is_interface_usable
			a_stone_is_stone_usable: a_stone /= Void implies is_stone_usable (a_stone)
		deferred
		ensure
			stone_set: equal (stone, a_stone)
		end

feature -- Status report

	has_stone: BOOLEAN
			-- Indicates if Current has a stone set.
		do
			Result := stone /= Void
		ensure
			stone_attached: (Result and stone /= Void) or else (not Result and stone = Void)
		end

feature -- Query

	is_stone_usable (a_stone: ?STONE): BOOLEAN
			-- Determines if a stone can be used by Current.
			--
			-- `a_stone': Stone to determine usablity.
			-- `Result': True if the stone can be used, False otherwise.
		require
			is_interface_usable: is_interface_usable
			a_stone_attached: a_stone /= Void
		deferred
		end

feature -- Basic operations

	query_set_stone (a_stone: ?STONE): BOOLEAN
			-- Determines if a stone can be set, possibly using a UI to ask the user for confirmation.
			-- Note: This function should not be used in any contracts due to the possibility of UI presentation.
			--
			-- `a_stone': Stone to query if setting is possible.
			-- `Result': True if the stone can be set, False otherwise.
		require
			is_interface_usable: is_interface_usable
			a_stone_is_stone_usable: a_stone /= Void implies is_stone_usable (a_stone)
		do
			Result := True
		end

feature -- Synchronization

	synchronize
			-- Synchronizes any new data (compiled or other wise)
		require
			is_interface_usable: is_interface_usable
		deferred
		end

invariant
	stone_is_stone_usable: stone /= Void implies is_stone_usable (stone)

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
