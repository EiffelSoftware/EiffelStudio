note
	description: "Eiffel Vision tree node. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_NODE_IMP

inherit
	EV_TREE_NODE_I
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_TREE_NODE, EV_TREE_NODE_IMP]
		redefine
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP

	EV_TREE_NODE_ACTION_SEQUENCES_IMP

	EV_PND_DEFERRED_ITEM
		redefine
			interface
		end

	EV_ITEM_IMP
		undefine
			pixmap_equal_to,
			parent,
			create_drop_actions
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create the tree item.
		do
			base_make (an_interface)
			internal_text := ""
		end

feature -- Status report

	is_dockable: BOOLEAN

	is_selected: BOOLEAN
			-- Is the item selected?
		do
		end

	is_expanded: BOOLEAN
			-- is the item expanded?
		do
			Result := internal_is_expanded
		end

feature -- Measurement

	minimum_width: INTEGER
			-- Minimum horizontal size in pixels.
		local
			l_tree_imp: like parent_tree_imp
		do
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
				Result := l_tree_imp.minimum_width
			end
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		local
			l_tree_imp: like parent_tree_imp
		do
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
				Result := l_tree_imp.row_height
			end
		end

feature {EV_ANY_I} -- Status setting

	enable_select
			-- Select `Current' in its parent.
		do
		end

	disable_select
			-- Disable selection of `Current' in its parent.
		do
		end

	set_expand (a_flag: BOOLEAN)
			-- Expand the item if `flag', collapse it otherwise.
		local
			i: INTEGER
		do
			internal_is_expanded := a_flag
			if a_flag = true then
				-- Make sure all children are expanded if needed
				from
					i := 1
				until
					i >= count
				loop
					if i_th (i).is_expanded then
--TODO						i_th (i).implementation.set_expand (true)
					end
					i := i + 1
				end
			else
			end
		end

	set_text (a_text: STRING_GENERAL)
			-- Set 'text' to 'a_text'
		do
			internal_text := a_text -- .twin??
			if parent_tree_imp /= Void then
			end
		end

feature {EV_ANY_I} -- Implementation

	parent_tree_imp: EV_TREE_IMP
		do
			if parent_tree /= Void then
				Result ?= parent_tree.implementation
			end
		end

feature {EV_TREE_IMP, EV_TREE_NODE_IMP} -- Implementation

	internal_is_expanded: BOOLEAN

feature {EV_TREE_IMP, EV_TREE_NODE_IMP} -- Implementation

	ensure_expandable
			-- Ensure `Current' is displayed as expandable.
		do
		end

	remove_expandable
			-- Ensure `Current' is no longer displayed as expandable.
		do
		end

	text: STRING_32
			-- Text displayed.
		do
			if internal_text = Void then
				create Result.make_empty
			else
				Result := internal_text.twin
			end
		ensure then
			text_not_void: Result /= Void
		end

	tooltip: STRING_32
			-- Tooltip if any.
		do
			if internal_tooltip = Void then
				Result := ""
			else
				Result := internal_tooltip.twin
			end
		ensure then
			tooltip_not_void: Result /= Void
		end

	remove_internal_text
			-- Make `internal_text' Void
		do
			internal_text := Void
		end

	set_internal_text (a_text: STRING_GENERAL)
			-- Set `internal_text' to `a_text'
		do
			internal_text := a_text
		end

	internal_text: STRING_32
		-- Internal representation of `text'.

	internal_tooltip: STRING_32
		-- Internal representation of `tooltip'.

	set_tooltip (a_text: STRING_GENERAL)
			-- Set `a_text' to `tooltip'.
		do
			internal_tooltip := a_text
		end

	remove_tooltip
			-- Remove text of `tooltip'.
		do
			internal_tooltip := ""
		end

	pix_width, pix_height: INTEGER
			-- Height and width of pixmap in Tree.

	insert_item (item_imp: EV_TREE_NODE_IMP; pos: INTEGER)
			-- Insert `item_imp' at the `index' position.
		do
			-- TODO: optimization potential, only reload under the current item
			if parent_tree_imp /= void then
				parent_tree_imp.outline_view.reload_item_reload_children ({EV_ANY_IMP}.NULL, True)
			end
		end

	remove_item (item_imp: EV_TREE_NODE_IMP)
			-- Remove `item_imp' from `Current'.
		do
			-- TODO: optimization potential, only reload under the current item
			if parent_tree_imp /= void then
				parent_tree_imp.outline_view.reload_item_reload_children ({EV_ANY_IMP}.NULL, True)
			end
		end

	expanded_on_last_item_removal: BOOLEAN
		-- Was `Current' expanded upon removal of last item


	width: INTEGER
		do
			io.put_string ("EV_TREE_NODE_IMP.width: Not implemented%N")
		end

	height: INTEGER
		do
			io.put_string ("EV_TREE_NODE_IMP.height: Not implemented%N")
		end

	screen_x: INTEGER
		do
			io.put_string ("EV_TREE_NODE_IMP.screen_x: Not implemented%N")
		end

	screen_y: INTEGER
		do
			io.put_string ("EV_TREE_NODE_IMP.screen_y: Not implemented%N")
		end

	x_position: INTEGER
		do
			io.put_string ("EV_HEADER_ITEM_IMP.x_position: Not implemented%N")
		end

	y_position: INTEGER
		do
			io.put_string ("EV_HEADER_ITEM_IMP.y_position: Not implemented%N")
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE_NODE;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_TREE_NODE_IMP

