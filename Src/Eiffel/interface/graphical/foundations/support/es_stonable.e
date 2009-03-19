note
	description: "[
		Basic implementation of {ES_STONABLE_I}.
		
		Be sure to check out {ES_STONABLE_SYNCHRONIZED} for implemented synchronization behavior.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_STONABLE

inherit
	ES_STONABLE_I

feature -- Access

	stone: detachable STONE assign set_stone
			-- <Precursor>

feature -- Element change

	set_stone (a_stone: like stone)
			-- <Precursor>
		local
			l_old_stone: like stone
		do
			l_old_stone := stone
			if l_old_stone /= a_stone then
				stone := a_stone
				on_stone_changed (l_old_stone)
				if attached internal_stone_changed_actions as l_actions then
					l_actions.call ([Current, l_old_stone])
				end
			end
		end

feature -- Actions

	stone_changed_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [sender: ES_STONABLE_I; old_stone: detachable STONE]]
			-- <Precursor>
		do
			if attached internal_stone_changed_actions as l_result then
				Result := l_result
			else
				create Result
				internal_stone_changed_actions := Result
			end
		end

feature {NONE} -- Action handler

	on_stone_changed (a_old_stone: detachable like stone)
			-- Called when the stone changed.
			--
			-- `a_old_stone': Previous stone set in Current.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature {NONE} -- Implementation: Internal cache

	internal_stone_changed_actions: like stone_changed_actions
			-- Cache version of `stone_changed_actions'
			-- Note: Do not use directly!

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
