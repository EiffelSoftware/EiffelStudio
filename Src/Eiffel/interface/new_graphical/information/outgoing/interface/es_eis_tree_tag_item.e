note
	description: "EIS tag item for the tree"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_TREE_TAG_ITEM

inherit
	EB_CLASSES_TREE_ITEM
		redefine
			set_pixmap
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING_GENERAL)
			-- Create a tree item representing class `a_class' with `a_name' in its context.
		require
			a_name_ok: a_name /= Void
		do
			default_create
			set_text (a_name)
			associated_pixmap := pixmaps.icon_pixmaps.information_tag_icon
			set_pixmap (associated_pixmap)
			pointer_button_press_actions.extend (agent register_pressed_item)
		end

feature -- Status change

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- <Precursor>
		do
			associated_pixmap := a_pixmap
			Precursor (a_pixmap)
		end

feature -- Access

	stone: STONE
			-- No stones for tags.
		do
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
