note
	description: "Eiffel Vision tree node. Carbon implementation."
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

	EV_ITEM_LIST_IMP [EV_TREE_NODE]
		export
			{EV_TREE_IMP}
				child_array
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

	EV_CARBON_DATABROWSER_ITEM
		undefine
			child_array
		redefine
			interface,
			text
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	destroy
			-- Clean up `Current'
		do
			set_is_destroyed (True)
		end

	make (an_interface: like interface)
			-- Create the tree item.
		do
			base_make (an_interface)
			internal_text := ""
		end

feature -- Status report

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

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		local
			l_tree_imp: like parent_tree_imp
		do
			-- Return parents horizontal scrollbar offset.
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
			end
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		local
			l_tree_imp: like parent_tree_imp
		do
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
			end
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		local
			l_tree_imp: like parent_tree_imp
		do
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
				Result := l_tree_imp.screen_x + x_position
			end
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		local
			l_tree_imp: like parent_tree_imp
		do
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
				Result := l_tree_imp.screen_y + y_position
			end
		end

	width: INTEGER
			-- Horizontal size in pixels.
		local
			l_tree_imp: like parent_tree_imp
		do
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
				Result := l_tree_imp.width
			end
		end

	height: INTEGER
			-- Vertical size in pixels.
		local
			l_tree_imp: like parent_tree_imp
		do
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
				Result := l_tree_imp.row_height
			end
		end

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
			ret: INTEGER
			i: INTEGER
		do
			internal_is_expanded := a_flag
			if a_flag = true then
				ret := open_data_browser_container_external (parent_tree_imp.c_object, item_id)
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
				ret := close_data_browser_container_external (parent_tree_imp.c_object, item_id)
			end
		end

	set_text (a_text: STRING_GENERAL)
			-- Set 'text' to 'a_text'
		local
			ret: INTEGER
		do
			internal_text := a_text -- .twin??
			if parent_tree_imp /= Void then
				ret := update_data_browser_items_external (parent_tree_imp.c_object, 0, 1, $item_id, 1, 1)
			end
		end

feature -- PND

	enable_transport
			-- Enable PND transport
		do
		end

	disable_transport
			-- Disable PND transport
		do
		end

	draw_rubber_band
		do
		end

	erase_rubber_band
		do
		end

	enable_capture
		do
		end

	disable_capture
		do
			check
				do_not_call: False
			end
		end

	start_transport (
        	a_x, a_y, a_button: INTEGER; a_press: BOOLEAN;
        	a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        	a_screen_x, a_screen_y: INTEGER; a_menu_only: BOOLEAN)
        	-- Start PND transport (not needed)
		do
			check
				do_not_call: False
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
		a_screen_x, a_screen_y: INTEGER)
			-- End PND transport (not needed)
		do
			check
				do_not_call: False
			end
		end

	set_pointer_style, internal_set_pointer_style (curs: EV_POINTER_STYLE)
			-- Set 'pointer_style' to 'curs' (not needed)
		do
			check
				do_not_call: False
			end
		end

	is_transport_enabled_iterator: BOOLEAN
			-- Has 'Current' or a child of 'Current' pnd transport enabled?
		do
		end

feature {EV_TREE_IMP} -- Implementation

	set_pebble_void
			-- Resets pebble from Tree_Imp.
		do
			pebble := Void
		end

	able_to_transport (a_button: INTEGER): BOOLEAN
			-- Is the row able to transport data with `a_button' click.
		do
		end

feature {EV_ANY_I} -- Implementation

	set_parent_imp (par_imp: like parent_imp)
		do
			parent_imp := par_imp
		end

	parent_imp: EV_ITEM_LIST_IMP [EV_TREE_NODE]

	parent_tree_imp: EV_TREE_IMP
		do
			if parent_tree /= Void then
				Result ?= parent_tree.implementation
			end
		end

feature {EV_TREE_IMP, EV_TREE_NODE_IMP} -- Implementation

	internal_is_expanded: BOOLEAN

feature {EV_TREE_IMP, EV_TREE_NODE_IMP} -- Implementation

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
			-- Do nothing
		end

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
				create Result. make_empty
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

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Set the pixmap for 'Current'.
		local
			ret: INTEGER
			pixmap_imp: EV_PIXMAP_IMP
		do
			-- First load the pixmap into the button
			pixmap_imp ?= a_pixmap.implementation

			icon_ref := pixmap_imp.drawable
		end

	pix_width, pix_height: INTEGER
			-- Height and width of pixmap in Tree.

	remove_pixmap
			-- Remove the pixmap for `Current'
		local
			par_tree: EV_TREE_IMP
		do
			par_tree := parent_tree_imp
			if par_tree /= Void then
				par_tree.update_row_pixmap (Current)
			end
		end

	pixmap: EV_PIXMAP
			-- Pixmap displayed in 'Current' if any.
		do
		end

	insert_i_th (v: like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			item_imp: EV_TREE_NODE_IMP
			par_t_imp: EV_TREE_IMP
			id: INTEGER
		do
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)
			child_array.go_i_th (i)
			child_array.put_left (v)

			par_t_imp := parent_tree_imp
			if par_t_imp /= Void then
				item_imp.add_item_and_children_to_parent_tree (par_t_imp, Current, i)
			end
			--id := parent_tree_imp.get_id (item_imp) -- Currently buggy: we may not have a tree from which we can get an ID yet.
			--item_imp.set_item_id (id)
		end

	remove_i_th (a_position: INTEGER)
			-- Remove item at `a_position'
		do
		end

	expanded_on_last_item_removal: BOOLEAN
		-- Was `Current' expanded upon removal of last item

feature {NONE} -- Redundant implementation

	real_pointed_target: EV_PICK_AND_DROPABLE
		do
			check do_not_call: False end
		end

feature {NONE} -- Implementation

	dispose
			-- Clean up
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE_NODE;

note
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- class EV_TREE_NODE_IMP

