note
	description: "List Item Cocoa Implementation"
	author: "Daniel Furrer"
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

	make
			-- Initialize `Current'
		do
			internal_text := once ""
			set_is_initialized (True)
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is the item selected.
--		do
--			if parent_imp /= Void then
--			--	Result := parent_imp.selected_items.has (interface)
--			end
--		end

	minimum_width, minimum_height: INTEGER

	is_dockable: BOOLEAN

	text: STRING_32
			-- <Precursor>
		do
			Result := internal_text.twin
		end

feature -- Status setting

	enable_select
			-- Select the item.
		do
			--parent_imp.select_item (parent_imp.index_of (interface, 1))
			is_selected := True
		end

	disable_select
			-- Deselect the item.
		do
			--parent_imp.deselect_item (parent_imp.index_of (interface, 1))
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
			if attached internal_tooltip as l_tooltip then
				Result := l_tooltip.twin
			else
				Result := ""
			end
		end

	set_text (a_text: STRING_GENERAL)
			-- Set current button text to `txt'.
		do
			internal_text := a_text.twin
		end

feature {NONE} -- Implementation

	width: INTEGER
		do
--			io.put_string ("EV_LIST_ITEM.width: Not implemented%N")
		end

	height: INTEGER
		do
--			io.put_string ("EV_LIST_ITEM.height: Not implemented%N")
		end

	screen_x: INTEGER
		do
--			io.put_string ("EV_LIST_ITEM.screen_x: Not implemented%N")
		end

	screen_y: INTEGER
		do
--			io.put_string ("EV_LIST_ITEM.screen_y: Not implemented%N")
		end

	x_position: INTEGER
		do
--			io.put_string ("EV_LIST_ITEM.x_position: Not implemented%N")
		end

	y_position: INTEGER
		do
--			io.put_string ("EV_LIST_ITEM.y_position: Not implemented%N")
		end

	internal_text: STRING_32
		-- Text displayed in `Current'

feature {EV_LIST_ITEM_LIST_IMP} -- Implementation

	internal_tooltip: detachable STRING_32
		-- Tooltip used for `Current'.

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_LIST_ITEM note option: stable attribute end;

end -- class EV_LIST_ITEM_IMP
