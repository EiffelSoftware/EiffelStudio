indexing
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

	make (is_pool: BOOLEAN) is
			-- Create a list containing available buttons if `is_pool' or displayed buttons otherwise
		do
			default_create
			is_a_pool_list := is_pool
		end

feature -- Access

	customizable_item: EB_CUSTOMIZABLE_LIST_ITEM is
			-- Convert `item' into a EB_CUSTOMIZABLE_LIST_ITEM
		do
			Result ?= item
		end

	customizable_selected_item: EB_CUSTOMIZABLE_LIST_ITEM is
			-- Convert `selected_item' into a EB_CUSTOMIZABLE_LIST_ITEM
		do
			Result ?= selected_item
		end

feature -- Status Report

	is_a_pool_list: BOOLEAN
			-- Is the list a pool list? (as opposed to a list displaying the buttons shown in the tool bar)

feature -- Basic operations

	extend (v: like item) is
   			-- Add `v' to end. Do not move cursor.
		local
			a_customizable_item: like customizable_item
			pix: EV_PIXMAP
		do
				-- Set the size of the pixmaps in the list the same
				-- as the real size of the pixmaps
			if is_empty then
				a_customizable_item ?= v
				if v /= void then
					pix := a_customizable_item.data.pixmap @ 1
					set_pixmaps_size (pix.width, pix.height)
				end
			end

				-- Call the original `extend'.
			Precursor (v)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_CUSTOM_TOOLBAR_LIST
