indexing
	description: "Grid item to display a query lanauge item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_QUERY_LANGUAGE_ITEM

inherit
	EB_GRID_COMPILER_ITEM
		redefine
			image,
			set_style
		end

create
	make

feature{NONE} -- Initialization

	make (a_item: like item; a_style: like style) is
			-- Initialize `item' with `a_item'.
		require
			a_item_attached: a_item /= Void
			a_style_attached: a_style /= Void
		do
			default_create
			item := a_item
			set_spacing (layout_constants.Tiny_padding_size)
			set_style (a_style)
		ensure
			item_set: item = a_item
		end

feature -- Access

	item: QL_ITEM
			-- Query language item associated with Current

	item_pixmap: EV_PIXMAP is
			-- Pixmap associated to current compiler item
		do
			if item.parent /= Void then
				Result := pixmap_for_query_lanaguage_item (item.parent)
			else
				Result := pixmaps.icon_pixmaps.general_blank_icon
			end
		end

	image: STRING is
			-- Image of current used in search
		do
			if image_internal = Void then
				image_internal := style.image (Current).twin
			end
			Result := image_internal
		end

feature -- Setting

	set_style (a_style: like style) is
			-- Set `style' with `a_style'.
		do
			image_internal := Void
			Precursor (a_style)
		end

invariant
	item_attached: item /= Void

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
