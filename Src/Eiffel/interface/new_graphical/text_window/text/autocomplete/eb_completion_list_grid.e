indexing
	description: "Grid support editor token rendering, and internal item text pick and drop"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COMPLETION_LIST_GRID

inherit
	EV_GRID
		redefine
			initialize
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialization
		do
			Precursor
			pick_ended_actions.force_extend (agent on_pick_ended)
			set_item_pebble_function (agent on_pick)
		end

feature {NONE} -- Implementation

	on_pick_ended (a_item: EV_ABSTRACT_PICK_AND_DROPABLE) is
			-- Action performed when pick ends
		local
			l_item: EB_GRID_EDITOR_TOKEN_ITEM
		do
			l_item ?= last_picked_item
			if l_item /= Void then
				l_item.set_last_picked_token (0)
				if l_item.is_parented then
					l_item.redraw
				end
			end
			last_picked_item := Void
		ensure
			last_picked_item_not_attached: last_picked_item = Void
		end

	on_pick (a_item: EV_GRID_ITEM): ANY is
			-- Action performed when pick on `a_item'.
		local
			l_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_stone: STONE
			l_index: INTEGER
		do
			last_picked_item := Void
			l_item ?= a_item
			if l_item /= Void then
				l_index := l_item.token_index_at_current_position
				if l_index > 0 then
					Result := l_item.editor_token_pebble (l_index)
					l_stone ?= Result
					if l_stone /= Void then
						remove_selection
						set_accept_cursor (l_stone.stone_cursor)
						set_deny_cursor (l_stone.x_stone_cursor)
						l_item.set_last_picked_token (l_index)
						l_item.redraw
						last_picked_item := l_item
					end
				end
			end
		end

	last_picked_item: EV_GRID_ITEM
			-- Last picked item

invariant
	invariant_clause: True -- Your invariant here

indexing
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
