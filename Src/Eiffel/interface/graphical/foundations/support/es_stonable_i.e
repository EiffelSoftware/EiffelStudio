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

	set_stone (a_stone: ?like stone)
			-- Sets current stone.
			-- Note: This call is unprotected and will set the stone regardless. For a protected call
			--       use `set_stone_with_query', which will interactive with the user if necessary
			--
			-- `a_stone': Stone to set.
		require
			is_interface_usable: is_interface_usable
			a_stone_is_stone_usable: a_stone /= Void implies is_stone_usable (a_stone)
		deferred
		ensure
			stone_set: equal (stone, a_stone)
		end

	frozen set_stone_with_query (a_stone: ?like stone)
			-- Sets the current stone and preforms a protected call to ensure a stone can be set.
			-- This does not guarentee a stone will be set because it depends on possible user interaction
			-- to confirm setting.
			--
			-- `a_stone': Stone to set.
		require
			is_interface_usable: is_interface_usable
			not_is_setting_stone_with_query: not is_setting_stone_with_query
			a_stone_is_stone_usable: a_stone /= Void implies is_stone_usable (a_stone)
		do
			if not is_setting_stone_with_query then
				if query_set_stone (a_stone) then
					is_setting_stone_with_query := True
					set_stone (a_stone)
					is_setting_stone_with_query := False
				end
			else
				set_stone (a_stone)
			end
		ensure
			is_setting_stone_with_query_unchanged: is_setting_stone_with_query = old is_setting_stone_with_query
		end

feature -- Status report

	has_stone: BOOLEAN
			-- Indicates if Current has a stone set.
		do
			Result := stone /= Void
		ensure
			stone_attached: (Result and stone /= Void) or else (not Result and stone = Void)
		end

feature -- Status report

	is_setting_stone_with_query: BOOLEAN
			-- Indicates if a stone is currenly being set using `set_stone_with_query'

	frozen is_stone_usable (a_stone: ?like stone): BOOLEAN
			--  Determines if a stone can be used by Current.
			--| Note: Redefine `internal_is_stone_usable' to extend usablity checking.
			--
			-- `a_stone': Stone to determine usablity.
			-- `Result': True if the stone can be used, False otherwise.
		require
			is_interface_usable: is_interface_usable
		do
			if {l_stone: like stone} a_stone then
				Result := l_stone.is_valid and then internal_is_stone_usable (l_stone)
			else
				Result := a_stone = Void
			end
		ensure
			a_stone_is_valid: Result implies (a_stone = Void or else a_stone.is_valid)
		end

feature {NONE} -- Status report

	internal_is_stone_usable (a_stone: !like stone): BOOLEAN
			-- Determines if a stone can be used by Current.
			--
			-- `a_stone': Stone to determine usablity.
			-- `Result': True if the stone can be used, False otherwise.
		require
			a_stone_is_valid: a_stone.is_valid
		deferred
		end

feature -- Query

	query_set_stone (a_stone: ?like stone): BOOLEAN
			-- Determines if a stone can be set, possibly using a UI to ask the user for confirmation.
			-- Note: This function should not be used in any contracts due to the possibility of UI presentation.
			--
			-- `a_stone': Stone to query if setting is possible.
			-- `Result': True if the stone can be set, False otherwise.
		require
			is_interface_usable: is_interface_usable
			a_stone_is_stone_usable: a_stone /= Void implies is_stone_usable (a_stone)
			not_is_setting_stone_with_query: not is_setting_stone_with_query
		do
			Result := True
		end

feature -- Basic operations

	refresh_stone
			-- Refreshes current stone.
			-- Note: Refreshing performs a query to `query_set_stone' to ensure any resistance is handled correctly.
			--       This means clients should not perform any checks using `query_set_stone' themselves.
		require
			is_interface_usable: is_interface_usable
			has_stone: has_stone
			not_is_setting_stone_with_query: not is_setting_stone_with_query
		local
			l_stone: like stone
		do
			l_stone := stone
			if l_stone /= Void and then (is_setting_stone_with_query or else query_set_stone (Void)) then
				is_setting_stone_with_query := True
				set_stone (Void)
				if is_stone_usable (l_stone) then
						-- Recheck usability, just in case.
					set_stone (l_stone)
				else
					check False end
				end
				is_setting_stone_with_query := False
			end
		ensure
			is_setting_stone_with_query_unchanged: is_setting_stone_with_query = old is_setting_stone_with_query
		end

feature -- Synchronization

	synchronize
			-- Synchronizes any new data (compiled or other wise)
		require
			is_interface_usable: is_interface_usable
			not_is_setting_stone_with_query: not is_setting_stone_with_query
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
