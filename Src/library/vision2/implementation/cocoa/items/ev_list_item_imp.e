note
	description: "List Item Cocoa Implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LIST_ITEM_IMP

inherit
	EV_LIST_ITEM_I
		redefine
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP

	EV_PND_DEFERRED_ITEM
		redefine
			interface
		end

	EV_LIST_ITEM_ACTION_SEQUENCES_IMP

	EV_ITEM_IMP
		undefine
			parent, pixmap_equal_to, create_drop_actions
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a list item with an empty name.
		do
			base_make (an_interface)
		end

	initialize
			-- Initialize `Current'
		do
			internal_text := once ""
			set_is_initialized (True)
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is the item selected.
		do
			if parent_imp /= Void then
			--	Result := parent_imp.selected_items.has (interface)
			end
		end

	minimum_width, minimum_height: INTEGER

	is_dockable: BOOLEAN

feature -- Status setting

	enable_select
			-- Select the item.
		do
			--parent_imp.select_item (parent_imp.index_of (interface, 1))
		end

	disable_select
			-- Deselect the item.
		do
			--parent_imp.deselect_item (parent_imp.index_of (interface, 1))
		end

	text: STRING_32
			--
		do
			Result := internal_text.twin
		end

feature -- Element change

	set_tooltip (a_tooltip: STRING_GENERAL)
			-- Assign `a_tooltip' to `tooltip'.
		do
			internal_tooltip := a_tooltip.twin
		end

	tooltip: STRING_32
			-- Tooltip displayed on `Current'.
		do
			if internal_tooltip /= Void then
				Result := internal_tooltip.twin
			else
				Result := ""
			end
		end

	set_text (txt: STRING_GENERAL)
			-- Set current button text to `txt'.
		do
			internal_text := txt.twin
			if parent_imp /= Void then
			--	parent_imp.set_text_on_position (parent_imp.index_of (interface, 1) , txt)
			end
		end

feature {NONE} -- Implementation

	internal_text: STRING_32
		-- Text displayed in `Current'

feature {EV_LIST_ITEM_LIST_IMP} -- Implementation

	internal_tooltip: STRING_32
		-- Tooltip used for `Current'.

feature {EV_LIST_ITEM_LIST_IMP, EV_LIST_ITEM_LIST_I} -- Implementation

	interface: EV_LIST_ITEM;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_LIST_ITEM_IMP

