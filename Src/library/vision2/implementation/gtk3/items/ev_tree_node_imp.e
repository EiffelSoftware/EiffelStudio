note
	description: "Eiffel Vision tree node. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_NODE_IMP

inherit
	EV_TREE_NODE_I
		export
			{EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} expand_actions_internal, collapse_actions_internal
		redefine
			interface,
			reset_pebble_function
		end

	EV_ITEM_LIST_IMP [EV_TREE_NODE]
		export
			{EV_TREE_IMP}
				child_array
		redefine
			interface,
			make
		end

	EV_PND_DEFERRED_ITEM
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	destroy
			-- Clean up `Current'
		do
			if attached parent_imp as l_parent_imp then
				l_parent_imp.prune (attached_interface)
			end
			set_is_destroyed (True)
		end

	old_make (an_interface: attached like interface)
			-- Create the tree item.
		do
			assign_interface (an_interface)
		end

	make
		do
			remove_internal_text
			Precursor
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is the item selected?
		local
			a_tree_imp: detachable EV_TREE_IMP
		do
			a_tree_imp := parent_tree_imp
			if a_tree_imp /= Void then
				Result := a_tree_imp.selected_item = interface
			end
		end

	is_expanded: BOOLEAN
			-- is the item expanded?
		local
			a_tree_path: POINTER
			par_tree: detachable EV_TREE_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			par_tree := parent_tree_imp
			check par_tree /= Void then end
			l_list_iter := list_iter
			check l_list_iter /= Void then end
			a_tree_path := {GTK2}.gtk_tree_model_get_path (par_tree.tree_store, l_list_iter.item)
			Result := {GTK2}.gtk_tree_view_row_expanded (par_tree.tree_view, a_tree_path)
			{GTK2}.gtk_tree_path_free (a_tree_path)
		end

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		local
			l_h_adjust: POINTER
			l_tree_imp: like parent_tree_imp
		do
			-- Return parents horizontal scrollbar offset.
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
				l_h_adjust := {GTK}.gtk_scrolled_window_get_hadjustment (l_tree_imp.scrollable_area)
				if l_h_adjust /= default_pointer then
					Result := - {GTK}.gtk_adjustment_get_value (l_h_adjust).rounded
				end
			end
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		local
			l_v_adjust: POINTER
			l_tree_imp: like parent_tree_imp
		do
			l_tree_imp := parent_tree_imp
			if l_tree_imp /= Void then
				Result := (index - 1) * l_tree_imp.row_height
				l_v_adjust := {GTK}.gtk_scrolled_window_get_vadjustment (l_tree_imp.scrollable_area)
				if l_v_adjust /= default_pointer then
					Result := Result - {GTK}.gtk_adjustment_get_value (l_v_adjust).rounded
				end
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
		local
			a_selection: POINTER
			par_tree: detachable EV_TREE_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			par_tree := parent_tree_imp
			if par_tree /= Void then
				l_list_iter := list_iter
				check l_list_iter /= Void then end
				a_selection := {GTK2}.gtk_tree_view_get_selection (par_tree.tree_view)
				{GTK2}.gtk_tree_selection_select_iter (a_selection, l_list_iter.item)
				par_tree.ensure_item_visible (attached_interface)
			end
		end

	disable_select
			-- Disable selection of `Current' in its parent.
		local
			a_selection: POINTER
			par_tree: detachable EV_TREE_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			par_tree := parent_tree_imp
			if par_tree /= Void then
				l_list_iter := list_iter
				check l_list_iter /= Void then end
				a_selection := {GTK2}.gtk_tree_view_get_selection (par_tree.tree_view)
				{GTK2}.gtk_tree_selection_unselect_iter (a_selection, l_list_iter.item)
			end
		end

	set_expand (a_flag: BOOLEAN)
			-- Expand the item if `flag', collapse it otherwise.
		local
			a_tree_path: POINTER
			par_tree: detachable EV_TREE_IMP
			a_success: BOOLEAN
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			par_tree := parent_tree_imp
			check par_tree /= Void then end
			l_list_iter := list_iter
			check l_list_iter /= Void then end
			a_tree_path := {GTK2}.gtk_tree_model_get_path (par_tree.tree_store, l_list_iter.item)
			if a_flag then
				{GTK2}.gtk_tree_view_expand_to_path (par_tree.tree_view, a_tree_path)
			else
				a_success := {GTK2}.gtk_tree_view_collapse_row (par_tree.tree_view, a_tree_path)
			end
			{GTK2}.gtk_tree_path_free (a_tree_path)
		end

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Set 'text' to 'a_text'
		local
			par_tree: detachable EV_TREE_IMP
		do
			internal_text := a_text.as_string_32.twin
			par_tree := parent_tree_imp
			if par_tree /= Void then
				par_tree.set_text_on_position (Current, internal_text)
			end
		end

feature -- PND

	enable_transport
			-- Enable PND transport
		do
			is_transport_enabled := True
			if attached parent_tree_imp as l_parent_tree_imp then
				l_parent_tree_imp.update_pnd_status
			end
		end

	disable_transport
			-- Disable PND transport
		do
			is_transport_enabled := False
			if attached parent_tree_imp as l_parent_tree_imp then
				l_parent_tree_imp.update_pnd_status
			end
		end

	draw_rubber_band
		do
			check
				do_not_call: False
			end
		end

	erase_rubber_band
		do
			check
				do_not_call: False
			end
		end

	enable_capture
		do
			check
				do_not_call: False
			end
		end

	disable_capture
		do
			check
				do_not_call: False
			end
		end

	start_transport (
        	a_x, a_y, a_button: INTEGER; a_press: BOOLEAN
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

	set_pointer_style, internal_set_pointer_style (c: EV_POINTER_STYLE)
			-- Set 'pointer_style' to 'c' (not needed)
		do
			check
				do_not_call: False
			end
		end

	is_transport_enabled_iterator: BOOLEAN
			-- Has 'Current' or a child of 'Current' pnd transport enabled?
		local
			a_cursor: CURSOR
			i: INTEGER
		do
			if is_transport_enabled then
				Result := True
			elseif count > 0 then
				from
					a_cursor := child_array.cursor
					i := 1
				until
					i > child_array.count or else Result
				loop
					if attached child_array [i] as ch then
						check attached {EV_TREE_NODE_IMP} ch.implementation as a_tree_node_imp then
							Result := a_tree_node_imp.is_transport_enabled_iterator
						end
					end
					i := i + 1
				end
				child_array.go_to (a_cursor)
			end
		end

	reset_pebble_function
			--Reset pebble_function.
		local
			l_parent_tree_imp: like parent_tree_imp
		do
			l_parent_tree_imp := parent_tree_imp
			if l_parent_tree_imp /= Void then
				l_parent_tree_imp.reset_pebble_function
			else
				Precursor
			end
		end

feature {EV_TREE_IMP} -- Implementation

	able_to_transport (a_button: INTEGER): BOOLEAN
			-- Is `Current' able to initiate transport with `a_button'.
		do
			Result := (mode_is_drag_and_drop and then a_button = 1) or
				(mode_is_pick_and_drop and then a_button = 3 and then not mode_is_configurable_target_menu)
		end

	ready_for_pnd_menu (a_button: INTEGER; a_press: BOOLEAN): BOOLEAN
			-- Will `Current' display a menu with button `a_button'.
		do
			Result := ((mode_is_target_menu or else mode_is_configurable_target_menu) and a_button = 3) and then not a_press
		end

feature {EV_ANY_I} -- Implementation

	set_list_iter (a_iter: EV_GTK_TREE_ITER_STRUCT)
			-- Set `list_iter' to `a_iter'
		do
			list_iter := a_iter
		end

	list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		-- Object representing position of `Current' in parent tree model

	set_parent_imp (par_imp: like parent_imp)
		do
			parent_imp := par_imp
		end

	parent_imp: detachable EV_ITEM_LIST_IMP [EV_TREE_NODE]

	parent_tree_imp: detachable EV_TREE_IMP
		do
			if attached {like parent_tree_imp} parent_tree_i as l_par_tree then
				Result := l_par_tree
			end
		end

feature {EV_TREE_IMP, EV_TREE_NODE_IMP} -- Implementation

	add_item_and_children_to_parent_tree (a_parent_tree: EV_TREE_IMP; a_parent_node: detachable EV_TREE_NODE_IMP; a_index: INTEGER)
			-- Used for setting items within parent tree
		local
			a_tree_iter: EV_GTK_TREE_ITER_STRUCT
			i: INTEGER
			a_parent_iter: POINTER
		do
			if a_parent_node /= Void and then attached a_parent_node.list_iter as l_list_iter then
				a_parent_iter := l_list_iter.item
			end
			create a_tree_iter.make
			set_list_iter (a_tree_iter)
			{GTK2}.gtk_tree_store_insert (a_parent_tree.tree_store, a_tree_iter.item, a_parent_iter, a_index - 1)
			a_parent_tree.set_text_on_position (Current, text)
			a_parent_tree.update_row_pixmap (Current)
			from
				i := 1
			until
				i > child_array.count
			loop
				check attached {EV_TREE_NODE_IMP} (child_array [i]).implementation as item_imp then
					item_imp.add_item_and_children_to_parent_tree (a_parent_tree, Current, i)
				end
				i := i + 1
			end
		end

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
			insert_i_th (create {EV_TREE_ITEM}, 1)
				-- Now remove the new item from `child_array'
				-- as we do not wish the item to be accessible from the interface.
			child_array.wipe_out
		end

	remove_expandable
			-- Ensure `Current' is no longer displayed as expandable.
		do
			if attached {EV_TREE_IMP} parent_imp then
				-- Check if 'child_array' count is less than actual count, if so remove last item
			else
				-- Nothing needs to be done if parent tree is Void
			end
		end

	text: STRING_32
			-- Text displayed.
		do
			Result := internal_text.twin
		ensure then
			text_not_void: Result /= Void
		end

	tooltip: STRING_32
			-- Tooltip if any.
		do
			if attached internal_tooltip as l_internal_tooltip then
				Result := l_internal_tooltip.twin
			else
				Result := ""
			end
		ensure then
			tooltip_not_void: Result /= Void
		end

	remove_internal_text
			-- Make `internal_text' Void
		do
			internal_text := once ""
		end

	set_internal_text (a_text: READABLE_STRING_GENERAL)
			-- Set `internal_text' to `a_text'
		do
			internal_text := a_text.as_string_32
		end

	internal_text: STRING_32
		-- Internal representation of `text'.

	internal_tooltip: detachable STRING_32
		-- Internal representation of `tooltip'.

	set_tooltip (a_text: READABLE_STRING_GENERAL)
			-- Set `a_text' to `tooltip'.
		do
			internal_tooltip := a_text.as_string_32
		end

	remove_tooltip
			-- Remove text of `tooltip'.
		do
			internal_tooltip := ""
		end

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Set the pixmap for 'Current'.
		local
			par_tree: detachable EV_TREE_IMP
		do
				-- Clean up previous pixmap if any
			if gdk_pixbuf /= default_pointer then
				{GTK2}.g_object_unref (gdk_pixbuf)
				gdk_pixbuf := default_pointer
			end
			check attached {EV_PIXMAP_IMP} a_pixmap.implementation as a_pix_imp then
				gdk_pixbuf := a_pix_imp.pixbuf_from_drawable
			end
			par_tree := parent_tree_imp
			if par_tree /= Void then
				par_tree.update_row_pixmap (Current)
			end
		end

	pix_width, pix_height: INTEGER
			-- Height and width of pixmap in Tree.

	remove_pixmap
			-- Remove the pixmap for `Current'
		local
			par_tree: detachable EV_TREE_IMP
		do
			if gdk_pixbuf /= default_pointer then
				{GTK2}.g_object_unref (gdk_pixbuf)
				gdk_pixbuf := default_pointer
			end
			par_tree := parent_tree_imp
			if par_tree /= Void then
				par_tree.update_row_pixmap (Current)
			end
		end

	pixmap: detachable EV_PIXMAP
			-- Pixmap displayed in 'Current' if any.
		do
			if gdk_pixbuf /= default_pointer then
				create Result
				check attached {EV_PIXMAP_IMP} Result.implementation as pix_imp then
					pix_imp.set_pixmap_from_pixbuf (gdk_pixbuf)
				end
			end
		end

	gdk_pixbuf: POINTER
		-- Stored gdk pixbuf data

	insert_i_th (v: attached like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			par_t_imp: detachable EV_TREE_IMP
		do
			check attached {EV_TREE_NODE_IMP} v.implementation as item_imp then
				item_imp.set_parent_imp (Current)

				child_array.go_i_th (i)
				child_array.put_left (v)

					-- Using a local prevents recalculation
				par_t_imp := parent_tree_imp
				if par_t_imp /= Void then
					item_imp.add_item_and_children_to_parent_tree (par_t_imp, Current, i)
					if item_imp.is_transport_enabled_iterator then
						par_t_imp.update_pnd_connection (True)
					end
				end
					-- Resume expansion status from last node removal
				if count = 1 and then par_t_imp /= Void then
					if expand_actions_internal /= Void then
						expand_actions_internal.block
					end
					set_expand (expanded_on_last_item_removal)
					if expand_actions_internal /= Void then
						expand_actions_internal.resume
					end
				end
			end
		end

	remove_i_th (a_position: INTEGER)
			-- Remove item at `a_position'
		local
			par_tree_imp: detachable EV_TREE_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			if count = 1 then
				if parent_tree_i /= Void then
					expanded_on_last_item_removal := is_expanded
				else
					expanded_on_last_item_removal := False
				end
			end
			check
				attached {EV_TREE_NODE_IMP} (child_array [a_position]).implementation as item_imp
			then
					-- Remove from tree if present
				par_tree_imp := parent_tree_imp
				if par_tree_imp /= Void then
					l_list_iter := item_imp.list_iter
					check l_list_iter /= Void then
						{GTK2}.gtk_tree_store_remove (par_tree_imp.tree_store, l_list_iter.item)
					end
				end
				item_imp.set_parent_imp (Void)
				child_array.go_i_th (a_position)
				child_array.remove

				if par_tree_imp /= Void then
					par_tree_imp.update_pnd_status
				end
			end
		end

	expanded_on_last_item_removal: BOOLEAN
		-- Was `Current' expanded upon removal of last item

feature {NONE} -- Redundant implementation

	real_pointed_target: detachable EV_PICK_AND_DROPABLE
		do
			check do_not_call: False end
		end

feature {NONE} -- Implementation

	dispose
			-- Clean up
		do
			if
				not is_in_final_collect and then
				not gdk_pixbuf.is_default_pointer
			then
				{GTK2}.g_object_unref (gdk_pixbuf)
				gdk_pixbuf := default_pointer
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TREE_NODE note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_TREE_NODE_IMP
