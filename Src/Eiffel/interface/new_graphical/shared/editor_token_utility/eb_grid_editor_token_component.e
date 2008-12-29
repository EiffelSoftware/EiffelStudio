note
	description: "Grid list item in which editor tokens are displayed"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_EDITOR_TOKEN_COMPONENT

inherit
	ES_GRID_EDITOR_TOKEN_COMPONENT

create
	make

feature{NONE} -- Initialization

	make (a_tokens: LIST [EDITOR_TOKEN]; a_leading_padding: INTEGER)
			-- Initialize.
		require
			a_tokens_attached: a_tokens /= Void
			a_leading_padding_non_negative: a_leading_padding >= 0
		do
			create editor_token_text
			editor_token_text.set_tokens (a_tokens)
			editor_token_text.disable_text_wrap
			leading_padding := a_leading_padding
		ensure
			leading_padding_set: leading_padding = a_leading_padding
		end

feature -- Access

	required_width: INTEGER
			-- Required width in pixel of Current component
		do
			Result := editor_token_text.required_width
		end

	required_height: INTEGER
			-- Required height in pixel of Current component
		do
			Result := editor_token_text.required_height
		end

	leading_padding: INTEGER
			-- Padding in pixels before the first editor token

	overriden_fonts: SPECIAL [EV_FONT]
			-- Overriden fonts
			-- Void if overriden fonts are not set.
		do
			Result := editor_token_text.overriden_fonts
		end

feature{ES_GRID_LIST_ITEM} -- Drawing

	display (a_drawable: EV_DRAWABLE; a_x, a_y: INTEGER; a_max_width, a_max_height: INTEGER)
			-- Draw Current component in `a_drawable' starting from (`a_x', `a_y').
			-- The maximum width and height in pixel for Current is `a_max_width' and `a_max_height' respectively.
		local
			l_parent: like grid_item
			l_selected: BOOLEAN
			l_focused: BOOLEAN
			l_token_text: like editor_token_text
		do
			l_parent := grid_item
			l_selected := l_parent.is_selected
			l_focused := l_parent.parent.has_focus
			l_token_text := editor_token_text
			l_token_text.set_maximum_size (a_max_width.max (1), a_max_height)
			if l_selected then
				l_token_text.display_selected (a_x + leading_padding, a_y, a_drawable, l_focused)
			else
				l_token_text.display (a_x + leading_padding, a_y, a_drawable, last_picked_token_index, l_focused)
			end
		end

feature -- Setting

	set_overriden_fonts (a_fonts: SPECIAL [EV_FONT]; a_height: INTEGER)
			-- Set overriden fonts and according height used to display Current instead default fonts for editor tokens.
		do
			editor_token_text.set_overriden_font (a_fonts, a_height)
		end

feature{NONE} -- Impelementation

	token_index_at_position (a_x, a_y: INTEGER): INTEGER
			-- Token item index in `editor_token_text' at position (`a_x', `a_y')
			-- Zero means that no editor token is at position (`a_x', `a_y').
		do
			Result := editor_token_text.token_index_at_position (a_x - leading_padding, a_y)
		end

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
