note
	description: "Object that represent a component used in grid domain item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_DOMAIN_ITEM_COMPONENT

inherit
	ES_GRID_EDITOR_TOKEN_COMPONENT

	EB_SHARED_WRITER

	EB_DOMAIN_ITEM_UTILITY

create
	make

feature{NONE} -- Initialization

	make (a_domain_item: like domain_item; a_padding: INTEGER)
			-- Initialize `domain_item' with `a_domain_item'.
		require
			a_domain_item_attached: a_domain_item /= Void
		do
			domain_item := a_domain_item
			create editor_token_text
			editor_token_text.set_overriden_font (label_font_table, label_font_height)
			token_writer.new_line
			editor_token_text.set_tokens (token_name_from_domain_item (domain_item))
			editor_token_text.disable_text_wrap
			padding := a_padding
		ensure
			domain_item_set: domain_item = a_domain_item
		end

feature -- Access

	domain_item: EB_DOMAIN_ITEM
			-- Domain item which will be displayed here

	required_width: INTEGER
			-- Required width in pixel of Current component
		do
			Result := editor_token_text.required_width + pixmap_from_domain_item (domain_item).width + padding
		end

	required_height: INTEGER
			-- Required height in pixel of Current component
		do
			Result := editor_token_text.required_height.max (pixmap_from_domain_item (domain_item).height)
		end

	padding: INTEGER
			-- Spacing in pixels between every two components

feature{ES_GRID_LIST_ITEM} -- Drawing

	display (a_drawable: EV_DRAWABLE; a_x, a_y: INTEGER; a_max_width, a_max_height: INTEGER)
			-- Draw Current component in `a_drawable' starting from (`a_x', `a_y').
			-- The maximum width and height in pixel for Current is `a_max_width' and `a_max_height' respectively.
		local
			l_parent: like grid_item
			l_selected: BOOLEAN
			l_focused: BOOLEAN
			l_token_text: like editor_token_text
			l_pixmap: EV_PIXMAP
			l_pixmap_width: INTEGER
			l_padding: INTEGER
		do
			l_parent := grid_item
			l_selected := l_parent.is_selected
			l_focused := l_parent.parent.has_focus
			l_token_text := editor_token_text
			l_pixmap := pixmap_from_domain_item (domain_item)
			l_pixmap_width := l_pixmap.width
			l_padding := padding
			l_token_text.set_maximum_size ((a_max_width - l_pixmap_width - l_padding).max (1), a_max_height)
			a_drawable.draw_pixmap (a_x, a_y, l_pixmap)
			if l_selected then
				l_token_text.display_selected (a_x + l_padding + l_pixmap_width, a_y, a_drawable, l_focused)
			else
				l_token_text.display (a_x + l_padding + l_pixmap_width, a_y, a_drawable, last_picked_token_index, l_focused)
			end
		end

feature{NONE} -- Implementation

	token_index_at_position (a_x, a_y: INTEGER): INTEGER
			-- Token item index in `editor_token_text' at position (`a_x', `a_y')
			-- Zero means that no editor token is at position (`a_x', `a_y').
		local
			l_pixmap: EV_PIXMAP
		do
			l_pixmap := pixmap_from_domain_item (domain_item)
			Result := editor_token_text.token_index_at_position (a_x - padding - l_pixmap.width, a_y)
		end

invariant
	domain_item_attached: domain_item /= Void

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
