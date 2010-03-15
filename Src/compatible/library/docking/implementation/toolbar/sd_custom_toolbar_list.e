note
	description	: "A list containing toolbar buttons in order to customize a tool bar"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

class
	SD_CUSTOM_TOOLBAR_LIST

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

	customizable_item: SD_CUSTOMIZABLE_LIST_ITEM
			-- Convert `item' into a EB_CUSTOMIZABLE_LIST_ITEM
		do
			Result ?= item
		end

	customizable_selected_item: SD_CUSTOMIZABLE_LIST_ITEM
			-- Convert `selected_item' into a EB_CUSTOMIZABLE_LIST_ITEM
		do
			Result ?= selected_item
		end

feature -- Status Report

	is_a_pool_list: BOOLEAN
			-- Is the list a pool list? (as opposed to a list displaying the buttons shown in the tool bar)

feature -- Basic operations

	extend (v: like item)
   			-- Add `v' to end. Do not move cursor
		local
			a_customizable_item: like customizable_item
			pix: EV_PIXMAP
		do
				-- Set the size of the pixmaps in the list the same
				-- as the real size of the pixmaps
			if is_empty then
				a_customizable_item ?= v
				if v /= void then
					pix := a_customizable_item.data.pixmap
					set_pixmaps_size (pix.width, pix.height)
				end
			end

				-- Call the original `extend'
			Precursor (v)
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class EB_CUSTOM_TOOLBAR_LIST
