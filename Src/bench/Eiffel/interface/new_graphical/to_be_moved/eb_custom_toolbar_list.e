indexing
	description	: "A list containing toolbar buttons in order to customize a tool bar"
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

creation
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

end -- class EB_CUSTOM_TOOLBAR_LIST
