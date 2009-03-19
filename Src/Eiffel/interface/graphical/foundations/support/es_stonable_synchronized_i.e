note
	description: "[
		Implements only the synchronization of {ES_STONABLE_I}.
		Most classes will also inherit {ES_STONABLE}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_STONABLE_SYNCHRONIZED_I

inherit
	ES_STONABLE_I

feature {ES_STONABLE_I} -- Synchronization

	synchronize
			-- <Precursor>
			--|Note: Redefine `is_stone_sychronization_required' instead of `synchornize' to prevent or
			--|      force stone synchronization.
		local
			l_stone: STONE
			l_new_stone: STONE
		do
			l_stone := stone
			if l_stone /= Void then
				l_new_stone := l_stone.synchronized_stone
			end
			if is_stone_sychronization_required (l_stone, l_new_stone) then
				is_in_stone_synchronization := True
				if l_new_stone /= Void and then is_stone_usable (l_new_stone) then
					set_stone (l_new_stone)
				else
					set_stone (Void)
				end
				is_in_stone_synchronization := False
			end
		rescue
			is_in_stone_synchronization := False
		end

feature {NONE} -- Status report

	is_in_stone_synchronization: BOOLEAN
			-- Indicates if a stone synchronization is taking place instead of a simple change of stone.
			-- This should be checked when changing the stone.

	is_stone_sychronization_required (a_old_stone: detachable STONE; a_new_stone: detachable STONE): BOOLEAN
			-- Determines if stone synchronization is required given two stones.
			--|Note: Redefine to better determine if a stone is applicable for synchronization, rather than
			--|      redefine `synchronize'.
			--
			-- `a_old_stone': The current "old" stone.
			-- `a_new_stone': The stone to be set if synchronization is required.
			-- `Result': True if the panel should be synchronized with the new stone.
		require
			is_interface_usable: is_interface_usable
		do
			Result := a_old_stone /~ a_new_stone or else
				(attached a_old_stone and then not a_old_stone.is_valid)
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
