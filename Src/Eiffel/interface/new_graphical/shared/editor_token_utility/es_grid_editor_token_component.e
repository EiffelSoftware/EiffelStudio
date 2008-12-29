note
	description: "Grid list item in which editor tokens are displayed"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_GRID_EDITOR_TOKEN_COMPONENT

inherit
	ES_GRID_ITEM_COMPONENT

	EB_SHARED_WRITER

feature -- Access

	pebble_at_position (a_x, a_y: INTEGER): ANY
			-- Pebble at position (`a_x', `a_y') which is related to Current component
			-- Void if no pebble is found.
		local
			l_data: like pebble_and_index_at_position
		do
			l_data := pebble_and_index_at_position (a_x, a_y)
			if l_data /= Void then
				Result := l_data.pebble
			end
		end

feature -- Actions

	on_pick (a_x, a_y: INTEGER)
			-- Action to be performed when pick occurs at position (`a_x', `a_y') relative to top-left corner of current item
		local
			l_data: like pebble_and_index_at_position
		do
			l_data := pebble_and_index_at_position (a_x, a_y)
			if l_data /= Void then
				set_last_picked_token_index (l_data.index)
				set_last_pebble (l_data.pebble)
			end
		end

	on_pick_ended
			-- Action to be performed when pick-and-drop process ended
		do
			set_last_picked_token_index (0)
			set_last_pebble (Void)
		end

feature{NONE} -- Implementation

	editor_token_text: EB_EDITOR_TOKEN_TEXT
			-- Editor token text to display `domain_item'

	last_picked_token_index: INTEGER
			-- Index of last picked token

	set_last_picked_token_index (a_index: INTEGER)
			-- Set `last_picked_token_index' with `a_index'.
		do
			last_picked_token_index := a_index
		ensure
			last_picked_token_index_set: last_picked_token_index = a_index
		end

	token_index_at_position (a_x, a_y: INTEGER): INTEGER
			-- Token item index in `editor_token_text' at position (`a_x', `a_y')
			-- Zero means that no editor token is at position (`a_x', `a_y').
		deferred
		end

	pebble_and_index_at_position (a_x, a_y: INTEGER): TUPLE [pebble: ANY; index: INTEGER]
			-- Pebble and its token index at position (`a_x', `a_y') which is related to Current component
			-- Void if no pebble is found.
		local
			l_index: INTEGER
		do
			l_index := token_index_at_position (a_x, a_y)
			if l_index > 0 then
				Result := [editor_token_text.pebble (l_index), l_index]
			end
		end

invariant
	editor_token_text_attached: editor_token_text /= Void

note
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
