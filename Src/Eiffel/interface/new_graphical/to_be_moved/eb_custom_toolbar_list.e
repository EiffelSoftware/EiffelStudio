note
	description	: "A list containing toolbar buttons in order to customize a tool bar"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CUSTOM_TOOLBAR_LIST

inherit
	EV_LIST
		redefine
			extend
		end

create
	make

feature {NONE} -- Initialization

	make (is_pool: BOOLEAN)
			-- Create a list containing available buttons if `is_pool' or displayed buttons otherwise
		do
			default_create
			is_a_pool_list := is_pool
		end

feature -- Access

	customizable_item: detachable EB_CUSTOMIZABLE_LIST_ITEM
			-- Convert `item' into a EB_CUSTOMIZABLE_LIST_ITEM
		do
			Result := {EB_CUSTOMIZABLE_LIST_ITEM} / item
		end

	customizable_selected_item: EB_CUSTOMIZABLE_LIST_ITEM
			-- Convert `selected_item' into a EB_CUSTOMIZABLE_LIST_ITEM
		do
			Result := {EB_CUSTOMIZABLE_LIST_ITEM} / selected_item
		end

feature -- Status Report

	is_a_pool_list: BOOLEAN
			-- Is the list a pool list? (as opposed to a list displaying the buttons shown in the tool bar)

feature -- Basic operations

	extend (v: like item)
   			-- Add `v' to end. Do not move cursor.
		do
				-- Set the size of the pixmaps in the list the same
				-- as the real size of the pixmaps
			if
				is_empty and then
				attached {like customizable_item} v as a_customizable_item and then
				attached a_customizable_item.data.pixmap as pix
			then
				set_pixmaps_size (pix.width, pix.height)
			end

				-- Call the original `extend'.
			Precursor (v)
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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

end -- class EB_CUSTOM_TOOLBAR_LIST
